class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_counters
  def last_three_posts
    posts.order(created_at: :desc).limit(3)
  end
  def update_counters
    update(posts_counter: posts.count)
  end
end

