class AddViewCountToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :view_count, :integer
  end
end
