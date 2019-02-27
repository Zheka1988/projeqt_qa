class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, length: { maximum: 50 }, presence: true
  validates :body, length: { maximum: 500 }, presence: true
end
