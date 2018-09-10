class AddVoteScoreToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :vote_score, :integer
  end
end
