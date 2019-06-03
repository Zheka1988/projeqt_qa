class Voiting < ApplicationRecord
  belongs_to :question#, polymorphic: true
  # belongs_to :users

  validates_numericality_of :like, :dislike, only_integer: true
end
