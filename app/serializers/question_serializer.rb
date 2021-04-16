class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :question_answers
end
