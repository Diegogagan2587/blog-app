class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_counter_posts
  # next method will reutunr 5 most recent comments for a post
  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_counter_posts
    author.update(posts_counter: author.posts.count)
  end
end
