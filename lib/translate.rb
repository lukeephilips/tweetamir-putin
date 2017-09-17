class Translator
  # require('easy_translate')
  require 'httparty'
  require('dotenv')
  Dotenv.load


  def initialize(text)
    @auth = {username: ENV['WATSON_USERNAME'], password: ENV['WATSON_PASSWORD']}
    @text = text.gsub(/[^0-9a-z^\s]/i, '')
    @source = "en"
  end

  def spanish
    translate('es')
  end
  def japanese
    translate('ja')
  end
  def russian
    translate('ru')
  end

  def translate(lang)
    resp = HTTParty.post(
      "https://gateway.watsonplatform.net/language-translator/api/v2/translate?text='#{@text}'&source=#{@source}&target=#{lang}",
      :basic_auth => @auth
    )
    resp.parsed_response
  end

# EasyTranslate.api_key = ENV['GOOGLE_API_KEY']
end
