require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }

  it { should validate_presence_of :body }

  context "shoose_best_answer" do
    let!(:user) { create(:user) }
    let!(:question) { create :question, author: user }
    let!(:answer) { create :answer, question:question, author: user }
    let!(:answer2) { create :answer, question:question, author: user }

    it "change best answer" do
      answer.shoose_best_answer
      expect(answer.best).to eq true
    end

    it "only one answer can be best" do
      answer.shoose_best_answer
      answer2.shoose_best_answer
      expect(Answer.where(best: true).count).to eq 1
    end
  end
end
