require 'rails_helper'

RSpec.describe Voiting, type: :model do
  it { should belong_to :voitingable }

  it { should validate_numericality_of(:like).only_integer }
  it { should validate_numericality_of(:dislike).only_integer }
end
