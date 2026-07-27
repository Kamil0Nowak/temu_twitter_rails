module TweetsHelper
  def display_author(tweet)
    Current.user.is_tweet_owner?(tweet) ? "me" : tweet.user.email_address
  end
end
