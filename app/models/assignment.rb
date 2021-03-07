class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :student_assignments
  has_many :students, through: :student_assignments

  validates :name, presence: true

  after_create :add_to_assignments

  def add_to_assignments
    if self.course
      self.course.students.each do |student|
        student.assignments << self
      end
    end
  end

end