class TestSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :total_question
  has_many :questions

  def total_question
    object.questions.not_delete.length
  end
end
