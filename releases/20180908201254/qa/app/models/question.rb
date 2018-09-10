class Question < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
  has_many :answers
  has_many :comments, as: :post
  has_many :views, as: :post
  has_many :votes, as: :post
end
