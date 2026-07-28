module TweetsHelper
  def display_author(tweet)
    tweet.user.email_address
  end
end
