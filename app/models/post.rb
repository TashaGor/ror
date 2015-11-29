class Post < ActiveRecord::Base
  has_many :comments
  has_many :categories_posts
  has_many :categories, through: :categories_posts
  has_many :posts_tags
  has_many :tags
  belongs_to :user

  has_many :posts_subscribers
  has_many :subscribers, through: :posts_subscribers, source: :user

  validates :title, :body, presence: true

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :reverse_order, ->(order) { order(created_at: order) }

  def categories_titles
    categories.pluck(:name).join(', ')
  end
end
