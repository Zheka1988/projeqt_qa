require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:authored_answers) }
  it { should have_many(:authored_questions) }
end
