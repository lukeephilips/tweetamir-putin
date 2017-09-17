# require('easy_translate')
# require('bing_translator')
require 'httparty'
require('dotenv')
Dotenv.load

auth = {username: ENV['WATSON_USERNAME'], password: ENV['WATSON_PASSWORD']}
text = "fuck microsoft"
source = "en"
target="es"

resp = HTTParty.post(
  "https://gateway.watsonplatform.net/language-translator/api/v2/translate?text=#{text}&source=#{source}&target=#{target}",
  :basic_auth => {username: "9088e3f6-3350-4e4f-b815-7382293b8400", password: "1udWIYuNy1yF"}
)
resp.parsed_response

# EasyTranslate.api_key = ENV['GOOGLE_API_KEY']
# @translator = BingTranslator.new(ENV['COGNITIVE_SUBSCRIPTION_KEY'])
