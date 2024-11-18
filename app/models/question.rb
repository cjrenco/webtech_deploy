class Question < ApplicationRecord
  belongs_to :forum
  belongs_to :utilizer
  has_many :answers
  validates :title, :content, presence: true
end
