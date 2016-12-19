require('twitter')
require('.env')

  config = {
  consumer_key:    twitter_consumer_key,
  consumer_secret: twitter_consumer_secret,
  access_token:    twitter_access_token,
  access_token_secret: twitter_access_token_secret,
  }

  $twitter_client = Twitter::REST::Client.new(config)
