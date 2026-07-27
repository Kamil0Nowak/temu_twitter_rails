class Tweet < ApplicationRecord
  validates :body, presence: true, length: { minimum: 3, maximum: 280 }

  scope :ordered_by_most_recent, -> { self.order(created_at: :desc) }
end
