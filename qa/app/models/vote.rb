class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post, polymorphic: true
  validates_inclusion_of :upvote, in: [true, false]
end
