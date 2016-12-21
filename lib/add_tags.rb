class String
  def add_tags do
    tagged = text.split(' ')
    tagged.map! do |word|
      if starts_with?('@') | starts_with?('#')
        link = word[1..-1]
        word = '@' + "<a href='https://twitter.com/#{link}'>" + link + '</a>'
      elsif starts_with?('#')
        link = word[1..-1]
        word = '#' + "<a href='https://twitter.com/hashtag/#{link}?src=hash'>" + link + '</a>'
      end
    end
    tagged.join(' ')
  end
end
