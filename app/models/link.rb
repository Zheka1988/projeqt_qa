class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true
  # belongs_to :question
  # belongs_to :answer

  validates :name, :url, presence: true


end
