class String
  def add_tags
    tagged = self.split(' ')
    final = []
    tagged.each do |word|
      if word.start_with?('@')
        link = word[1..-1]
        word = '<span class="light-blue-text text-darken-1">@</span>' + "<a href='https://twitter.com/#{link}'>" + link + '</a>'
      elsif word.start_with?('#')
        link = word[1..-1]
        word = '<span class="light-blue-text text-darken-1">#</span>' + "<a href='https://twitter.com/hashtag/#{link}?src=hash'>" + link + '</a>'
      elsif word.start_with?('https://')
        word = "<a href='#{word}'>" + word + '</a>'
      end
      final.push(word)
    end
    final.join(' ')
  end
end
