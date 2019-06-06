class Voiting < ApplicationRecord
  belongs_to :question, optional: true
  belongs_to :answer, optional: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: [ :question_id, :answer_id ] }
  # validates :user_id, uniqueness: { scope: [ :answer_id ] }
end
