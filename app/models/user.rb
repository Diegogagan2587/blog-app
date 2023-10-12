class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :bio, presence: true

  before_save :validate_posts_counter

  def last_three_posts
    posts.order(created_at: :desc).limit(3)
  end

  def validate_posts_counter
    self.posts_counter = 0 if posts_counter.nil?
  end
end
