class Question < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable#, inverse_of: :parent
  has_many :rewards, dependent: :destroy, as: :rewardable

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :rewards, reject_if: :all_blank

  validates :title, presence: true
  validates :body, presence: true
end
