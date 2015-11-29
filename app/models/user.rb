class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile
  has_many :posts
  has_many :comments, through: :posts

  has_many :posts_subscribers
  has_many :subscribed_posts, through: :posts_subscribers, source: :post

  def author_of?(object)
    id == object.user_id
  end
end
