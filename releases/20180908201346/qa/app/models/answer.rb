class Answer < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :post
  has_many :views, as: :post
  has_many :votes, as: :post
end
