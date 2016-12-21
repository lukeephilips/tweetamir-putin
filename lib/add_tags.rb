class String
  def add_tags
    tagged = self.split(' ')
    final = []
    tagged.each do |word|
      if word.start_with?('@')
        link = word[1..-1]
        word = '@' + "<a href='https://twitter.com/#{link}'>" + link + '</a>'
      elsif word.start_with?('#')
        link = word[1..-1]
        word = '#' + "<a href='https://twitter.com/hashtag/#{link}?src=hash'>" + link + '</a>'
      elsif word.start_with?('https://')
        word = "<a href='#{word}'>" + word + '</a>'
      end
      final.push(word)
    end
    final.join(' ')
  end
end
