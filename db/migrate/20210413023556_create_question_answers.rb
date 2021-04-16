class CreateQuestionAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :question_answers do |t|
      t.integer :index
      t.string :content
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
