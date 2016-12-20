require('easy_translate')
require('dotenv')
Dotenv.load

EasyTranslate.api_key = ENV['GOOGLE_API_KEY']
