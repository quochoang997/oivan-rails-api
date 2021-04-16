class Test < ApplicationRecord
  attribute :mark_for_delete, :boolean, default: false
  has_many :questions, -> { not_delete.by_date }, inverse_of: :test
  accepts_nested_attributes_for :questions, allow_destroy: true
  # , reject_if: proc { |attributes| attributes.blank? }

  scope :not_delete, -> { where(mark_for_delete: false) }
  scope :by_name, -> { order('name ASC') }

  validates_presence_of :name, :description
  validate :require_question

  private
    def require_question
      errors.add(:base, "You must provide at least one question") if questions.size == 0
    end
end
