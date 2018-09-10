class AddPostToComment < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :post, polymorphic: true
  end
end
