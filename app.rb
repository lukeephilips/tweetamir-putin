require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require('./lib/tweet')
require('./lib/translate')
require('easy_translate')
require('dotenv')
require('pry')
Dotenv.load

get('/') do
  @tweets = []
  @translated = []
  erb(:index)
end


post('/') do
  user_name = params['user_name']
  @translated = []
  language = params['language'].to_sym
  @tweets = $twitter_client.user_timeline(user_name)
  @tweets.each() do |tweet|
    @translated.push(EasyTranslate.translate(tweet.text, :to => language))
  end
  if params['switch']
    @target_user = params['target_user']
  end
  # $twitter_client.update(user_name)
  # @tweets = $twitter_client.search(user_name, result_type: "recent").take(3).collect
  erb(:index)
end

post('/tweet') do
  tweet = params['tweet']
  target = params['target']
  output_tweet = ""
  if target != ""
    @output_tweet = "@".concat(target).concat(" ").concat(tweet)
  else
    @output_tweet = tweet
  end
  $twitter_client.update(@output_tweet)
  redirect('/')
end
