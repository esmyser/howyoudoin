class TwitterWrapper
  attr_reader :client

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

  def nyc_tweets
    begin
      collect_with_max_id do |max_id|
        options = {result_type: "recent", geocode: "40.7731295,-73.957734,5mi", locale: "en", count: 100, include_rts: false}
        options[:max_id] = max_id if max_id.present?
        # options[:since_id] = since_id if since_id.present?
        @client.search("", options)
      end
      
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end
  
  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id) if collection.empty? || collection.last[:created_at] > (Time.now - 1.hour)
    max_id = response.attrs[:statuses].last[:id] - 1 if response
    # since_id = response.attrs[:statuses].first[:id]
    collection += response.attrs[:statuses] if response
    response.nil? || response.attrs[:statuses].empty? ? collection.flatten : collect_with_max_id(collection, max_id, &block)
  end


end