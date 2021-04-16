class QuestionAnswer < ApplicationRecord
  belongs_to :question, inverse_of: :question_answers

  validates_presence_of :question, :index, :content
end
