class AddViewsToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :views, :integer
  end
end
