class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :text, presence: true

  after_save :update_counter_comments
  after_destroy :update_counter_comments

  def author=(author)
    self.user = author
  end

  def update_counter_comments
    post.update(comments_counter: post.comments.count)
  end
end
