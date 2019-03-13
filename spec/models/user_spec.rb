require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:authored_answers) }
    it { should have_many(:authored_questions) }
  end

  describe "Methods" do
    let(:user) { create(:user) }
    it "valid verification of authorship" do
      question = FactoryBot.create(:question, author: user)
      expect(user).to be_author_of(question)
    end

    it "invalid verification of authorship" do
      # other_user = User.create(email: "false@mail.ru", password: "12345678", password_confirmation: "12345678")
      other_user = FactoryBot.create(:user)
      question = FactoryBot.create(:question, author: other_user)
      expect( user.author_of?(question) ).to eq false
    end
  end

end
