class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :links, dependent: :destroy, as: :linkable
  has_many :voitings,  dependent: :destroy

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true

  def shoose_best_answer
    Answer.transaction do
      self.question.answers.where(best: true).update(best: false)
      self.update!(best: true)
      self.question.reward.update(user_id: self.author.id )
    end
  end

  def sum_raiting
    self.voitings.sum(:raiting)
  end

end
