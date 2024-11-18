class Forum < ApplicationRecord
  belongs_to :lesson
  has_many :questions, dependent: :destroy
  validates :title, presence: true
end
