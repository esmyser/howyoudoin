class NycSentimentController < ApplicationController

  def index
    @tweets = Tweet.all
    gon.tweets = @tweets
  end

end