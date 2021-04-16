class Assessment < ApplicationRecord
  belongs_to :user
  belongs_to :test
  has_many :assessment_responses, inverse_of: :assessment
  accepts_nested_attributes_for :assessment_responses, allow_destroy: true

  validates_presence_of :user, :test, :score, :total_question
end
