class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :posts, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :bio, presence: false

  def initialize(attributes = {})
    super
    self.posts_counter = 0
  end

  def last_three_posts
    posts.order(created_at: :desc).limit(3)
  end
end
