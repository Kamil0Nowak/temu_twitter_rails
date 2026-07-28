class TweetsController < ApplicationController
  allow_unauthenticated_access only: [ :index ]
  def index
    if authenticated?
      @tweets = Tweet.ordered_by_most_recent
      @tweet = Tweet.new
      render :index
    else
      render :landing
    end
  end

  def create
    @tweet = Current.user.tweets.build(tweet_params)

    if @tweet.save
      render turbo_stream: [
                turbo_stream.prepend("tweets", partial: "tweets/tweet", locals: { tweet: @tweet }),
                turbo_stream.replace("new_tweet", partial: "tweets/form", locals: { model: Tweet.new })
      ]
    else
      @tweets = Tweet.ordered_by_most_recent
      render :index, status: :unprocessable_entity, alert: "Tweet could not be created!"
    end
  end

  def destroy
    @tweet = Current.user.tweets.find(params[:id])
    @tweet.destroy

    render turbo_stream: [
      turbo_stream.remove(@tweet)
    ]

  rescue ActiveRecord::RecordNotFound
    redirect_to tweets_path, alert: "Tweet could not be deleted!"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
