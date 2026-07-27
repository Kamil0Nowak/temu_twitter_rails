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
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to tweets_path, notice: "Tweet created!" }
      end

    else
      @tweets = Tweet.ordered_by_most_recent
      render :index, status: :unprocessable_entity, alert: "Tweet could not be created!"
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
