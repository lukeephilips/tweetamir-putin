require('easy_translate')
require('bing_translator')

require('dotenv')
Dotenv.load

EasyTranslate.api_key = ENV['GOOGLE_API_KEY']

@translator = BingTranslator.new(ENV['COGNITIVE_SUBSCRIPTION_KEY'])
