class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  has_many :questions
  has_many :answers
  has_many :comments
end
