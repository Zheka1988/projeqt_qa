class Question < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :answers, dependent: :destroy

  has_many_attached :files

  validates :title, presence: true
  validates :body, presence: true
end
