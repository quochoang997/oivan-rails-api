class AssessmentResponseSerializer < ActiveModel::Serializer
  attributes :id, :is_correct, :response, :display_order
  belongs_to :question
end
