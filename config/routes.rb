Rails.application.routes.draw do

  root "nyc_sentiment#index"

  get "/show" => "nyc_sentiment#show"
  
end
