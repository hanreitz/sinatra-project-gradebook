class Teacher < ActiveRecord::Base
  has_many :courses
  has_many :students, through: :courses
  has_secure_password
end