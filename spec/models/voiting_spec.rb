require 'rails_helper'

RSpec.describe Voiting, type: :model do

  it { should belong_to :user }
  it { should belong_to :voitingable }

  context 'validation user' do
    let!(:user) { create(:user) }
    let!(:other_user_one) { create(:user) }
    let!(:question) { create :question, author: user }
    let!(:voiting) { create :voiting, voitingable_type: "Question", voitingable_id: question.id, user_id: other_user_one.id }

    it 'validation user_id' do
      expect(Voiting.new(voitingable_type: "Question", voitingable_id: question.id, user_id: other_user_one.id, raiting: 1)).to_not validate_presence_of :user_id
    end
  end
end
