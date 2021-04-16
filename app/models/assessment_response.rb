class AssessmentResponse < ApplicationRecord
  belongs_to :assessment, inverse_of: :assessment_responses
  belongs_to :question
  attribute :visible, :boolean, default: true

  validates_presence_of  :response, :display_order
  validates :is_correct, inclusion: { in: [ true, false ] }
end
