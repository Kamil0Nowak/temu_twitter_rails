class LikesController < ApplicationController
  before_action :set_tweet

  def create
    @tweet.likes.create!(user: Current.user)
    @tweet.reload

    @tweet.broadcast_replace_to(
      "tweets",
      target: ActionView::RecordIdentifier.dom_id(@tweet, :likes_count),
      partial: "likes/counter",
      locals: { tweet: @tweet }
    )

    render turbo_stream: turbo_stream.replace(
        ActionView::RecordIdentifier.dom_id(@tweet, :like_button),
        partial: "likes/button",
        locals: { tweet: @tweet }
    )
  end

  def destroy
    like = @tweet.likes.find(params[:id])
    like.destroy
    @tweet.reload

    @tweet.broadcast_replace_to(
      "tweets",
      target: ActionView::RecordIdentifier.dom_id(@tweet, :likes_count),
      partial: "likes/counter",
      locals: { tweet: @tweet }
    )

    render turbo_stream: turbo_stream.replace(
        ActionView::RecordIdentifier.dom_id(@tweet, :like_button),
        partial: "likes/button",
        locals: { tweet: @tweet }
    )
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end