class NycSentiment

  attr_accessor :hour_tweets, :sentiment

  def initialize
    nyc = {result_type: "recent", geocode: "40.7731295,-73.957734,5mi", locale: "en", count: 100, include_rts: false}
    @hour_tweets = TwitterWrapper.new('esmyser').last_hour_tweets(nyc)
    @sentiment = sentiment
    save_hour_tweets
  end

  def sentiment
    Sentimental.load_defaults
    Sentimental.new(0.1)
  end

  def save_hour_tweets
    @hour_tweets.each do |tweet|
      t = Tweet.new
      hydrate_tweet(t, tweet) if useable_tweet(t, tweet)
    end
  end

  def useable_tweet(t, tweet)
    t.anger = @sentiment.get_sentiment(tweet[:text])
    tweet[:coordinates].present? && (t.anger == "positive" || t.anger == "negative")
  end

  def hydrate_tweet(t, tweet)
    t.content = tweet[:text]
    t.tweet_time = tweet[:created_at].in_time_zone("Eastern Time (US & Canada)")
    t.handle = tweet[:user][:screen_name]
    t.user_id = tweet[:user][:id]
    t.tweet_id = tweet[:id]
    t.lat = tweet[:coordinates][:coordinates].first
    t.lng = tweet[:coordinates][:coordinates].last
    t.save
  end  

end