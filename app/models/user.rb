class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :authored_answers, class_name: 'Answer', foreign_key: :author_id
  has_many :authored_questions, class_name: 'Question', foreign_key: :author_id

  has_many :rewards, dependent: :destroy, as: :rewardable
  # accepts_nested_attributes_for :rewards, reject_if: :all_blank

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def author_of?(resource)
    self.id == resource.author_id
  end
end
