require 'uri'

class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true#, inverse_of: :child
  # belongs_to :question
  # belongs_to :answer

  validates :name, :url, presence: true
  validates :url, format: URI::regexp(%w[http https])

end
