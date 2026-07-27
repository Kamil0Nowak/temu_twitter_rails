class LikesController < ApplicationController
  before_action :set_tweet

  def create
    @tweet.likes.create!(user: Current.user)

    render turbo_stream: turbo_stream.replace(
      @tweet,
      partial: "tweets/tweet",
      locals: { tweet: @tweet }
    )
  end

  def destroy
    like = @tweet.likes.find(params[:id])
    like.destroy

    render turbo_stream: turbo_stream.replace(
      @tweet,
      partial: "tweets/tweet",
      locals: { tweet: @tweet }
    )
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end