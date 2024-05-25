class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  
  validates :comment, presence: { message: "コメントを入力してください" }
  
end
