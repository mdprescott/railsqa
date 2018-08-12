class AddVoteScoreToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :vote_score, :integer
  end
end
