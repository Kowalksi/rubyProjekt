# app/models/user.rb
class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy

  # Validations
  validates :role, presence: true

  # Enum for roles
  enum role: { user: 0, admin: 1 }

  # Optional: Set default role after creating a user
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end
end
