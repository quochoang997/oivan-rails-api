class CreateAssessmentResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :assessment_responses do |t|
      t.boolean :is_correct
      t.string :response
      t.integer :display_order
      t.boolean :visible
      t.references :assessment, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
