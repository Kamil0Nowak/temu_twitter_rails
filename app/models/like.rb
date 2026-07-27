class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  after_create_commit  { broadcast_update }
  after_destroy_commit { broadcast_update }

  private

  def broadcast_update
    current_count = tweet.likes.count
    broadcast_replace_to(
      "tweets",
      target: ActionView::RecordIdentifier.dom_id(tweet, :likes_count),
      html: current_count.to_s
    )
  end
end
