class Tweet < ActiveRecord::Base

  def self.happy_tweets
    self.all.where(anger: "positive")
  end

  def self.angry_tweets
    self.all.where(anger: "negative")
  end
end
