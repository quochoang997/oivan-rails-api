class Question < ApplicationRecord
  belongs_to :test, inverse_of: :questions
  has_many :question_answers, inverse_of: :question
  accepts_nested_attributes_for :question_answers, allow_destroy: true

  attribute :mark_for_delete, :boolean, default: false
  scope :not_delete, -> { where(mark_for_delete: false) }
  scope :by_date, -> { order('created_at ASC') }

  validates_presence_of :test, :name, :description, :correct_answer
  validate :require_question_answer

  def destroy
    update_attribute(:mark_for_delete, true)
  end

  private
    def require_question_answer
      errors.add(:base, "You must provide at least one answer") if question_answers.size == 0
    end
end
