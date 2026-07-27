class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def is_tweet_owner?(tweet)
    id == tweet.user_id
  end
end
