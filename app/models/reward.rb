class Reward < ApplicationRecord
  belongs_to :rewardable, polymorphic: true

  has_one_attached :file

  # belongs_to :linkable, polymorphic: true
  validates :name, presence: true
end
