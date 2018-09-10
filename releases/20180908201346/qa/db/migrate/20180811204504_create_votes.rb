class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :post, polymorphic: true
      t.boolean :upvote

      t.timestamps
    end
  end
end
