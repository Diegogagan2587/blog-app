class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_counter_likes
  after_destroy :update_counter_likes

  def update_counter_likes
    post.update(likes_counter: post.likes.count)
  end
end
