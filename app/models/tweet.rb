class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :body, presence: true, length: { minimum: 3, maximum: 280 }

  scope :ordered_by_most_recent, -> { self.order(created_at: :desc) }

  after_create_commit do
    broadcast_prepend_to("tweets", target: "tweets", partial: "tweets/tweet", locals: { tweet: self })
  end

  after_destroy_commit do
    broadcast_remove_to "tweets"
  end
end
