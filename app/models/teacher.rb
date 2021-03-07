class Teacher < ActiveRecord::Base
  has_many :courses
  has_many :students, through: :courses

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  has_secure_password
end