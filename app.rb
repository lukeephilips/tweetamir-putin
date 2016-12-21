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
require('./lib/emoji')
require('./lib/keyword')
require('./lib/sentence')


Dotenv.load

get('/') do
  @user_tweets = $twitter_client.user_timeline('Twittamir_Putin')
  @tweets = []
  @translated = []
  erb(:index)
end


post('/') do

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
  redirect('/user_search')
end

get('/user_search') do
  @user_tweets = $twitter_client.user_timeline('Twittamir_Putin')
  @tweets = []
  @translated = []
  erb(:user_search)
end

post('/user_search') do
  @user_tweets = $twitter_client.user_timeline('Twittamir_Putin')
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
  erb(:user_search)
end

get('/keyword_search') do
  @user_tweets = $twitter_client.user_timeline('Twittamir_Putin')
  @tweets = []
  @translated = []
  erb(:keyword_search)
end

post('/keyword_search') do
  @user_tweets = $twitter_client.user_timeline('Twittamir_Putin')
  search_term = params['search_term']
  @translated = []
  language = params['language'].to_sym
  @tweets = $twitter_client.search(search_term, result_type: "recent").take(20).collect
  @tweets.each() do |tweet|
    tweet_text_with_info = []
    tweet_text_with_info.push(tweet.user.name)
    tweet_text_with_info.push(tweet.user.screen_name)
    if language == :emojify
      str = tweet.text
      emoji_str = str.to_array
      tweet_text_with_info.push(emoji_str)
    else
      tweet_text_with_info.push(EasyTranslate.translate(tweet.text, :to => language))
    end
    @translated.push(tweet_text_with_info)
  end
  if params['switch']
    @target_user = params['target_user']
  end
  # $twitter_client.update(user_name)
  # @tweets = $twitter_client.search(user_name, result_type: "recent").take(3).collect
  erb(:keyword_search)
end

get '/emoji' do
  erb(:emoji)
end

post '/emoji' do
  sentence = params['sentence']
  @return = sentence.to_array

  erb(:emoji)
end
