class Post < ActiveRecord::Base
  has_many :comments
  has_many :categories_posts
  has_many :categories, through: :categories_posts
  has_many :posts_tags
  has_many :tags
  belongs_to :user

  validates :title, :body, presence: true

  def categories_titles
    categories.pluck(:name).join(', ')
  end
end
