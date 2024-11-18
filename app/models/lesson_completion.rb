class LessonCompletion < ApplicationRecord
  belongs_to :utilizer
  belongs_to :lesson

  validates :utilizer_id, uniqueness: { scope: :lesson_id, message: "You have already completed this lesson" }
end
