class TwitterWrapper
  attr_reader :client, :user

  def initialize(user)
     @user = user
     @client = client
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_key"]
      config.consumer_secret     = ENV["twitter_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end

  def last_hour_tweets(options)
    begin
      collect_tweets do |max_id|
        options[:max_id] = max_id if max_id.present?
        @client.search("", options)
      end
      
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end
  
  def collect_tweets(collection=[], max_id=nil, &block)
    response = yield(max_id) if collection.empty? || collection.last[:created_at] > (Time.now - 1.hour)
    max_id = response.attrs[:statuses].last[:id] - 1 if response
    collection += response.attrs[:statuses] if response
    response.nil? || response.attrs[:statuses].empty? ? collection.flatten : collect_tweets(collection, max_id, &block)
  end


end