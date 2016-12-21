class String
  def to_array

    sentence_array = self.split(" ")
    remove_list = ['a', 'the', 'an', 'of', 'if', 'or', 'in', 'where', 'were', 'is', 'it', 'to', 'am', 'are', 'that']
    ignore_list = ['@', '#', 'http']
    emojified_sentence =[]
    sentence_array.each do |word|

      #if the word is NOT on the remove_list
      if (!remove_list.include?(word))
        keyword_hash = Keyword.where("LOWER(keyword) LIKE LOWER(?)", "#{word}").first

        ignore = false
        ignore_list.each do |item|
          if word.include?(item)
            ignore = true
          end
        end

        if ignore
          emojified_sentence.push(word)

        elsif keyword_hash == nil # if nothing is returned when testing the whole word

          # run a double loop to push every substring from 0 to word length
          substrings = []
          (0...word.length).each do |i|
            (i...word.length).each do |j|
              if (j-i >= 2) # only push if substring is longer than two characters
                substrings.push(word[i..j])
              end
            end
          end

          #test each substring for a hit from the database and push each substring:emoji pair to an array
          emoji_array = []
          substrings.each do |str|
            test_str = Keyword.where("LOWER(keyword) LIKE LOWER(?)", "#{str}").first
            if test_str
              emoji_array.push([str, Emoji.find(test_str[:emoji_id]).image])
            end
          end

          #sort array so longest words will be replaced first and replace any hits in the original word
          emoji_array.sort! do |x,y|
            y[0].length <=> x[0].length
          end
          emoji_array.each do |pair|
            word.gsub!(pair[0], pair[1])
          end
          emojified_sentence.push(word)


        else # if whole word is returned push the image
          emojified_sentence.push(Emoji.find(keyword_hash[:emoji_id]).image)
        end
      end
    end
    emojified_sentence.join (" ")
  end
end
