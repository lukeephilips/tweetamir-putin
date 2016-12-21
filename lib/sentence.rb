class String
  def sentence_to_array(sentence)

    sentence_array = sentence.split(" ")
    remove_list = ['a', 'the', 'an', 'of', 'and', 'if', 'or', 'in', 'where', 'were', 'is', 'it', 'to', 'am']
    @return =[]
    sentence_array.each do |word|
      if !remove_list.include?(word)
        word = word.gsub(/[^0-9A-Za-z]/, '')
        keyword_hash = Keyword.where("keyword LIKE LOWER(?)", "#{word}").first
        test_word = word
        test_hash = keyword_hash
        if test_hash == nil
          # if test_word.end_with?("ing") or test_word.end_with?("ed") or test_word.end_with?("s") or test_word.end_with?("er")
            while test_word.end_with?("ing") or test_word.end_with?("ed") or test_word.end_with?("s") or test_word.end_with?("er")
              if test_word.end_with?('ing')
                test_word = word.chomp('ing')
                test_hash = Keyword.where("keyword LIKE LOWER(?)", "#{test_word}").first
                if test_hash
                  @return.push(Emoji.find(test_hash[:emoji_id]).image)
                end
              elsif test_word.end_with?('ed')
                test_word= word.chomp('ed')
                test_hash = Keyword.where("keyword LIKE LOWER(?)", "#{test_word}").first
                if test_hash
                  @return.push(Emoji.find(test_hash[:emoji_id]).image)
                end
              elsif test_word.end_with?('s')
                test_word = word.chomp('s')
                test_hash = Keyword.where("keyword LIKE LOWER(?)", "#{test_word}").first
                if test_hash
                  @return.push(Emoji.find(test_hash[:emoji_id]).image)
                end
              elsif test_word.end_with?('er')
                test_word = word.chomp('er')
                test_hash = Keyword.where("keyword LIKE LOWER(?)", "#{test_word}").first
                if test_hash
                  @return.push(Emoji.find(test_hash[:emoji_id]).image)
                end
              end
            end
          # else
            @return.push(word)
          # end
        else
          emoji_id = keyword_hash[:emoji_id]
          word_emoji = Emoji.find(emoji_id).image
          @return.push(word_emoji)
        end
      end
    end
  @return.join (" ")
  end
end
