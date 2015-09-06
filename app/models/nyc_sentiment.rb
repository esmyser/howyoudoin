class NycSentiment

  def save_hour_tweets
    tweets = TwitterWrapper.new('esmyser').nyc_tweets
    tweets.each do |tweet|
      t = Tweet.new
      t.content = tweet[:text]
      t.tweet_time = tweet[:created_at].in_time_zone("Eastern Time (US & Canada)")
      t.handle = tweet[:user][:screen_name]
      t.user_id = tweet[:user][:id]
      t.tweet_id = tweet[:id]
      # t.anger = 
      t.save
    end
  end

end