class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }

  before_save :validate_comments_counter
  before_save :validate_likes_counter

  after_save :update_counter_posts
  # next method will reutunr 5 most recent comments for a post
  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_counter_posts
    author.update(posts_counter: author.posts.count)
  end

  def validate_comments_counter
    self.comments_counter = 0 if comments_counter.nil?
  end

  def validate_likes_counter
    self.likes_counter = 0 if likes_counter.nil?
  end
end
