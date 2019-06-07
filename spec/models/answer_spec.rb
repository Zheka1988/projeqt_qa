require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:voitings).dependent(:destroy) }

  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :links }

  context "shoose_best_answer" do
    let!(:user) { create(:user) }
    let!(:question) { create :question, author: user }
    let!(:answer) { create :answer, question:question, author: user }
    let!(:answer2) { create :answer, question:question, author: user }
    let!(:reward) { create :reward, question: question}

    it "change best answer" do
      answer.shoose_best_answer
      expect(answer).to be_best
    end

    it "only one answer can be best" do
      answer.shoose_best_answer
      answer2.shoose_best_answer
      expect(Answer.where(best: true, question_id: question.id).count).to eq 1
    end
  end

  context "find out rating" do
    let!(:user) { create(:user) }
    let!(:other_user_one) { create(:user) }
    let!(:question) { create :question, author: user }
    let!(:answer) { create :answer, question:question, author: user }
    let!(:voiting) { create :voiting, voitingable_type: "Answer", voitingable_id: answer.id, user_id: other_user_one.id }

    it 'sum_raiting' do
      expect(answer.sum_raiting).to eq 1
    end
  end


end
