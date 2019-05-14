class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: "User", foreign_key: :author_id

  validates :body, presence: true

  def shoose_best_answer
    if self.question.answers.find_by(best: true)
      self.question.answers.where(best: true).update(best: false)
      self.update(best: true)
    else
      self.update(best: true)
    end
  end

end
