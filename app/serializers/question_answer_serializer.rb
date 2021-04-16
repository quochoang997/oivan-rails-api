class QuestionAnswerSerializer < ActiveModel::Serializer
  attributes :id, :index, :content
  attribute :is_correct, if: :is_teacher?

  def is_teacher?
    current_user.role == 'TEACHER'
  end
end
