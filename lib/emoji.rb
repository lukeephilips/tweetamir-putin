class Emoji < ActiveRecord::Base

  has_many(:keywords)
end
