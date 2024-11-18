class CourseEnrollment < ApplicationRecord
  belongs_to :utilizer
  belongs_to :course
end
