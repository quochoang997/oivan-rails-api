class AddIsCorrectToQuestionAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :question_answers, :is_correct, :boolean
  end
end
