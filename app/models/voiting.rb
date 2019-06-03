class Voiting < ApplicationRecord
  belongs_to :voitingable, polymorphic: true

  validates_numericality_of :like, :dislike, only_integer: true
end
