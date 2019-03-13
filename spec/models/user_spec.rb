require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:authored_answers) }
    it { should have_many(:authored_questions) }
  end

  describe "Methods" do
    user_t = User.first
    it "valid verification of authorship" do
      question = FactoryBot.create(:question, author: user_t)
      expect( user_t.author_of?(question) ).to eq true
    end

    it "invalid verification of authorship" do
      user_f = User.create(email: "false@mail.ru", password: "12345678", password_confirmation: "12345678")
      question = FactoryBot.create(:question, author: user_f)
      expect( user_t.author_of?(question) ).to eq false
    end
  end

end
