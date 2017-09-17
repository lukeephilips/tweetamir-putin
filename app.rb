require 'rubygems'
require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require('./lib/emoji')
require('./lib/keyword')
require('./lib/sentence')
require('./lib/tweet')
require('./lib/translate')
require('./lib/emoji')
require('./lib/keyword')
require('./lib/sentence')
require('./lib/add_tags')


require('pg')
require('dotenv')
require('pry')
require('byebug')
require 'httparty'
# require('easy_translate')

Dotenv.load

get('/') do
  user_tweets
  erb(:index)
end

post('/tweet') do
  tweet = params['tweet']
  putin = params['putin']
  if putin == "on"
    tweet = '@KremlinRussia_E ' + tweet
  end
  $twitter_client.update(tweet)
  redirect('/emoji')
end

post('/tweet_search') do
  tweet = params['tweet']
  putin = params['putin']
  if putin == "on"
    tweet = '@KremlinRussia_E ' + tweet
  end
  $twitter_client.update(tweet)
  redirect('/keyword_search')
end

post('/tweet_search_soviet') do
  tweet = params['tweet']
  tweet = '@KremlinRussia_E ' + tweet
  $twitter_client.update(tweet)
  redirect('/keyword_search/soviet')
end

get('/keyword_search') do
  user_tweets
  erb(:keyword_search)
end

post('/keyword_search') do
  user_tweets
  search_term = params['search-term']
  if !search_term.count("a-zA-Z0-9").zero?
    @tweets = $twitter_client.search(search_term, result_type: "recent").take(5).collect
    @tweets.each() do |tweet|
      @translated.push(tweet_text_with_info(tweet))
    end
  end
  if params['switch']
    @target_user = params['target_user']
  end
  erb(:keyword_search)
end

get '/emoji' do
  user_tweets
  erb(:emoji)
end

post '/emoji' do
  user_tweets
  tweet = Sentence.new params['sentence']
  es = Translator.new(tweet.sentence, 'es')
  ja = Translator.new(tweet.sentence, 'ja')
  ru = Translator.new(tweet.sentence, 'ru')



  @return = {
    :user_name => $twitter_client.user.name,
    :screen_name => $twitter_client.user.screen_name,
    :created_at => Time.now,
    :text => tweet.sentence,
    :emoji => tweet.to_emojis,
    # :russian => ru.translate,
    :spanish => es.translate,
    :japanese => ja.translate
  }

  erb(:emoji)
end

get '/emoji_tweet' do
    tweet_text = Sentence.new($twitter_client.mentions.first.text)
    @emoji_tweet = "@#{$twitter_client.mentions.first.user.user_name}"+" says "+" #{tweet_text.to_emojis}"
  erb(:test)
end
get '/tweet_back' do
  tweet_text = Sentence.new($twitter_client.mentions.first.text)

  @tweet_back = $twitter_client.update("@#{$twitter_client.mentions.first.user.user_name} #{tweet_text.to_emojis}").text
  @you_tweeted = true
  erb(:test)
end

get '/keyword_search/soviet' do
  user_tweets
  erb :keyword_search_soviet, :layout => :layout_soviet
end

post'/keyword_search/soviet' do
  user_tweets

  search_term = params['search-term']
  @tweets = $twitter_client.search(search_term, result_type: "recent").take(5).collect
  @tweets.each() do |tweet|
    @translated.push(tweet_text_with_info(tweet))
  end

  if params['switch']
    @target_user = params['target_user']
  end
  erb :keyword_search_soviet,:layout => :layout_soviet
end

def user_tweets
  @user_tweets = $twitter_client.user_timeline('TwittamirPutin')
  @tweets = []
  @translated = []
end

def tweet_text_with_info(tweet)
  tweet_text = Sentence.new(tweet.text)
  es = Translator.new(tweet.text, 'es')
  ja = Translator.new(tweet.text, 'ja')
  ru = Translator.new(tweet.text, 'ru')

  return {
    :user_name => tweet.user.name,
    :screen_name => tweet.user.screen_name,
    :created_at => tweet.created_at,
    :text => tweet.text,
    :emoji => tweet_text.to_emojis,
    # :russian => ru.translate,
    :spanish => es.translate,
    :japanese => ja.translate

  }
end
