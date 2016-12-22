require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require('./lib/emoji')
require('./lib/keyword')
require('./lib/sentence')
require('./lib/tweet')
require('./lib/translate')
require("pg")
require('easy_translate')
require('dotenv')
# require('pry')
require('./lib/emoji')
require('./lib/keyword')
require('./lib/sentence')
require('./lib/add_tags')
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

get('/keyword_search') do
  @user_tweets = $twitter_client.user_timeline('Twittamir_Putin')
  @tweets = []
  @translated = []
  erb(:keyword_search)
end

post('/keyword_search') do
  @user_tweets = $twitter_client.user_timeline('Twittamir_Putin')
  search_term = params['search-term']
  @translated = []
  # language = params['language'].to_sym
  @tweets = $twitter_client.search(search_term, result_type: "recent").take(5).collect
  @tweets.each() do |tweet|

    tweet_text_with_info = {:user_name => tweet.user.name, :screen_name => tweet.user.screen_name,
    :created_at => tweet.created_at, :text => tweet.text, :emoji => tweet.text.to_array,
    :russian => (EasyTranslate.translate(tweet.text, :to => :russian).to_s),
    :spanish => (EasyTranslate.translate(tweet.text, :to => :spanish)),
    :japanese => (EasyTranslate.translate(tweet.text, :to => :japanese))}
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

get '/emoji_tweet' do
    @emoji_tweet = "@#{$twitter_client.mentions.first.user.user_name}"+" says "+" #{$twitter_client.mentions.first.text.to_array}"
  erb(:test)
end
get '/tweet_back' do

  @tweet_back = $twitter_client.update("@#{$twitter_client.mentions.first.user.user_name} #{$twitter_client.mentions.first.text.to_array}").text
  @you_tweeted = true
  erb(:test)
end
