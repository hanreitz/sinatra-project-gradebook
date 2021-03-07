class StudentCourse < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  before_save :existing_assignments
    
  def existing_assignments
    self.course.assignments.each do |assignment|
      self.student.assignments << assignment unless self.student.assignments.include?(assignment)
    end
  end
end