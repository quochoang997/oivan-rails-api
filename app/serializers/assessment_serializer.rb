class AssessmentSerializer < ActiveModel::Serializer
  attributes :id, :score, :total_question, :created_at
  has_many :assessment_responses
end
