class Course < ApplicationRecord
  belongs_to :teacher, class_name: 'Utilizer', foreign_key: 'teacher_id'
  has_many :lessons, dependent: :destroy # Deletes associated lessons
  has_many :course_enrollments, dependent: :destroy # Deletes associated course enrollments
  has_many :enrolled_students, through: :course_enrollments, source: :utilizer
  has_many :course_progresses, dependent: :destroy # Deletes associated course progresses

  def completion_percentage(utilizer)
    total_lessons = lessons.count
    completed_lessons = lessons.joins(:lesson_completions).where(lesson_completions: { utilizer_id: utilizer.id }).count
    return 0 if total_lessons.zero?

    ((completed_lessons.to_f / total_lessons) * 100).round(2)
  end

  validates :name, :category, :teacher_id, presence: true
end
