class String
  def sentence_to_array(sentence)

    sentence_array = sentence.split(" ")
    remove_list = ['a', 'the', 'an', 'of', 'and', 'if', 'or', 'in', 'where', 'were', 'is', 'it', 'to', 'am']
    @return =[]
    sentence_array.each do |word|
      if !remove_list.include?(word)
        word = word.gsub(/[^0-9A-Za-z]/, '')
        keyword_hash = Keyword.where("LOWER(keyword) LIKE LOWER(?)", "#{word}").first

        test_word = word
        test_hash = keyword_hash

        if keyword_hash == nil # if nothing is returned when testing the whole word
          suffix = ['ing','ed','s','er']
          suffix.each do |suffix|
            if test_word.end_with?(suffix)
                test_hash = Keyword.where("LOWER(keyword) LIKE LOWER(?)", "#{test_word.chomp(suffix)}").first
                if test_hash
                  word = (Emoji.find(test_hash[:emoji_id]).image)
                end
              end
          end
            @return.push(word)
        else
          @return.push(Emoji.find(keyword_hash[:emoji_id]).image)
        end
      end
    end
  @return.join (" ")
  end
end
