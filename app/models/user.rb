class User < ApplicationRecord
  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, presence: true, uniqueness: true
  # validation
  validates_presence_of :email, :password_digest, :role

  scope :by_email, -> { order('email ASC') }

  ROLES = %w[TEACHER STUDENT]

  def is?(role)
    ROLES.include?(role.to_s)
  end
end
