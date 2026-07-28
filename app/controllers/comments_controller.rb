class CommentsController < ApplicationController
  before_action :set_tweet, only: [ :index, :create ]

  def index
    @comments = @tweet.comments.order(created_at: :desc)
  end
  def create
    @comment = @tweet.comments.create!(user: Current.user, content: comment_params)
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end