class Translator
  require('easy_translate')
  require 'httparty'
  require('dotenv')
  Dotenv.load


  def initialize(text, target)
    @auth = {username: ENV['WATSON_USERNAME'], password: ENV['WATSON_PASSWORD']}
    @text = text.gsub(/[^0-9a-z^\s]/i, '')
    @source = "en"
    @target=target
  end
  
  def translate
    resp = HTTParty.post(
      "https://gateway.watsonplatform.net/language-translator/api/v2/translate?text='#{@text}'&source=#{@source}&target=#{@target}",
      :basic_auth => @auth
    )
    resp.parsed_response
  end



# EasyTranslate.api_key = ENV['GOOGLE_API_KEY']
end
