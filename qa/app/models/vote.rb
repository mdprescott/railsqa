class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post, polymorphic: true
end
