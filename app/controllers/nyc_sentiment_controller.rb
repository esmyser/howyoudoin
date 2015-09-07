class NycSentimentController < ApplicationController

  def index
    @happy_tweets = Tweet.happy_tweets
    @angry_tweets = Tweet.angry_tweets
    gon.happyTweets = @happy_tweets
    gon.angryTweets = @angry_tweets
  end

  def show
  end

end