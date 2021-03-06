class Sentence
  def initialize(sentence)
    @sentence = sentence
    @substrings = []
    @emoji_array = []
    @emojified_sentence = []
  end
  def sentence
    @sentence
  end

  def to_emojis

    remove_list = ['a', 'an', 'and','the', 'of', 'if', 'or', 'in', 'where', 'were', 'is', 'it', 'to', 'am','@TwittamirPutin']

    sentence_array = @sentence.split(" ") - remove_list

    sentence_array.each do |word|
      if ignore_word?(word)
        @emojified_sentence.push(word)
      else
        found_keyword = Keyword.includes(:emoji).find_by(keyword: word)
        if found_keyword
          @emojified_sentence.push(found_keyword.emoji.image)
        else
          all_substrings(word)
          replace_substrings
          sort_and_replace(word)
        end
      end
    end
    @emojified_sentence.join (" ")
  end

  private
  def ignore_word?(word)
    ignore_list = ['@', '#', 'http']
    ignore_list.any? { |item| word.include?(item) }
  end

  def all_substrings(word)
    # runs a double loop to push every substring from 0 to word length
    @substrings.clear
    len = word.length
    (0...len).each do |i|
      (i+2...len).each do |j|
        @substrings.push(word[i..j])
      end
    end
  end
  def replace_substrings
    #tests each substring for a hit from the database and push each substring:emoji pair to an array
    @emoji_array.clear
    @substrings.each do |str|
      found = Keyword.includes(:emoji).find_by(keyword: str)
      if found
        @emoji_array.push([str, found.emoji.image])
      end
    end
  end
  def sort_and_replace(word)
    #sort array so longest words will be replaced first and replace any hits in the original word
    @emoji_array.sort! do |x,y|
      y[0].length <=> x[0].length
    end
    @emoji_array.each do |pair|
      word.gsub!(pair[0], pair[1])
    end
    @emojified_sentence.push(word)
  end
end
