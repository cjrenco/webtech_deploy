class Lesson < ApplicationRecord
  belongs_to :course
  has_many :forums, dependent: :destroy

  has_many :lesson_completions, dependent: :destroy
  has_many :utilizers, through: :lesson_completions
  
  validates :title, :content, presence: true
end