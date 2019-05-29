class Reward < ApplicationRecord
  belongs_to :question#, polymorphic: true
  belongs_to :user, optional: true
  has_one_attached :file

  # belongs_to :linkable, polymorphic: true
  validates :name, presence: true
end
