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
  erb(:index)
end


post('/') do
  user_name = params['user_name']
  # $twitter_client.update(user_name)
  @tweets = $twitter_client.user_timeline(user_name)
  # @tweets = $twitter_client.search(user_name, result_type: "recent").take(3).collect
  erb(:index)
end
