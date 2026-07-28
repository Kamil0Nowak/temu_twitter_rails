class CommentsController < ApplicationController
  before_action :set_tweet, only: [ :index, :create ]

  def index
    @comments = @tweet.comments.order(created_at: :desc).limit(5)
    @comment = @tweet.comments.new
  end

  def create
    @comment = @tweet.comments.build(comment_params)
    @comment.user = Current.user

    if @comment.save
      flash.now[:notice] = "Comment created!"
      render turbo_stream: [
        turbo_stream.prepend(
          helpers.dom_id(@tweet, :comments_list),
          partial: "comments/comment",
          locals: { comment: @comment }),
        turbo_stream.replace("flash", partial: "shared/alerts"),

        turbo_stream.replace(
                helpers.dom_id(@tweet, :comment_form),
               partial: "comments/form",
                 locals: { tweet: @tweet, comment: Comment.new }),
      ]
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end