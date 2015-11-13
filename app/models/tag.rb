class Tag < ActiveRecord::Base
  has_many :posts_tags
  has_many :posts
end
