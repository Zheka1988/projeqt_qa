require 'rails_helper'

RSpec.describe Voiting, type: :model do

  it { should belong_to :user }
  it { should belong_to :voitingable }

  let!(:user) { create(:user) }
  let!(:question) { create :question, author: user }
  let!(:voiting) { create :voiting, voitingable: question, user_id: user.id}
  # voiting = FactoryBot.create(:voiting, voitingable: question, user_id: user.id)
  # Voiting.create(raiting: 1, user_id: user.id, voitingable: question)
  # it { should validate_uniqueness_of(voiting.user_id).scoped_to(voiting.voitingable) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:voitingable) }
end
