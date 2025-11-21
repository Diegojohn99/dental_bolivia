class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, {
    admin: "admin",
    dentist: "dentist",
    receptionist: "receptionist"
  }, prefix: true

  validates :name, presence: true
  validates :role, presence: true
end
