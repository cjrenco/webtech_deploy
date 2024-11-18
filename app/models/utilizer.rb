class Utilizer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :courses, foreign_key: :teacher_id
    has_many :questions
    has_many :answers
    has_many :course_enrollments
    has_many :enrolled_courses, through: :course_enrollments, source: :course

    has_many :lesson_completions, dependent: :destroy
    has_many :completed_lessons, through: :lesson_completions, source: :lesson
    
    has_many :course_progresses
    validates :email, :password, :name, :last_name, :role, presence: true

    enum role: { student: 'student', teacher: 'teacher' }
    
    def full_name
      "#{name} #{last_name}"
    end

  end
  