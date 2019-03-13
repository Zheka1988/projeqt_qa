class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :authored_answers, class_name: 'Answer', foreign_key: :author_id
  has_many :authored_questions, class_name: 'Question', foreign_key: :author_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def author_of?(operand)
    self.id == operand.author_id
  end
end
