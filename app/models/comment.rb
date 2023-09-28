class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  def author=(author)
    self.user = author
  end
end
