class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :post, polymorphic: true
end
