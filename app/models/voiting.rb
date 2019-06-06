class Voiting < ApplicationRecord
  # belongs_to :question, optional: true
  # belongs_to :answer, optional: true
  belongs_to :user

  belongs_to :voitingable, polymorphic: true

  # validates :user_id, uniqueness: { scope: [ :question_id, :answer_id ] }
  validates :user_id, uniqueness: { scope: [ :voitingable_type, :voitingable_id ] }
end
