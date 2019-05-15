require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }

  it { should validate_presence_of :body }

  context "shoose_best_answer" do
    it "consist of first and last name" do
      user = create(:user)
      question = create :question, author: user
      answer = create :answer, question:question, author: user
      answer2 = create :answer, question:question, author: user

      answer.shoose_best_answer
      assert_equal true, answer.best

      answer2.shoose_best_answer
      assert_equal 1, Answer.where(best: true).count
    end
  end
end
