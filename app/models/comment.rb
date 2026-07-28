class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :content, presence: true, length: { minimum: 3, maximum: 255 }
end
