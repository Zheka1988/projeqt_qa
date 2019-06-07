require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:voitings).dependent(:destroy) }
  it { should have_one(:reward).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }
  it { should accept_nested_attributes_for :reward }

  it 'have many attached files' do
    expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  context "find out rating" do
    let!(:user) { create(:user) }
    let!(:other_user_one) { create(:user) }
    let!(:question) { create :question, author: user }
    let!(:voiting) { create :voiting, voitingable_type: "Question", voitingable_id: question.id, user_id: other_user_one.id }

    it 'sum_raiting' do
      expect(question.sum_raiting).to eq 1
    end
  end
end
