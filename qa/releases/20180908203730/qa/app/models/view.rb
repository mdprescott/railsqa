class View < ApplicationRecord
  belongs_to :user
  belongs_to :post, polymorphic: true
end
