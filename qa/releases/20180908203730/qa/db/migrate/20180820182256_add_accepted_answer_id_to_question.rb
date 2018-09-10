class AddAcceptedAnswerIdToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :accepted_answer_id, foreign_key: true
  end
end
