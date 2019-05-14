require 'rails_helper'

feature 'Author the question can shoose the best answer', %q{
  being on the question page,
  author can shoose, which answer is better
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create_list(:answer, 3, question: question, author: user) }

  scenario 'Unauthenticated user can not shoose the best answer' do
    visit questions_path(question)

    expect(page).to_not have_field('Best')
  end

  describe 'Authenticated user' do
    scenario 'can choose best Answer', js: true do
      sign_in user

      visit question_path(question)

      answer_best_id = Answer.second.id
      class_for_check = ".answer-" + answer_best_id.to_s + "-best"

      within class_for_check do
        check 'answer_best'
      end

      expect(page.find(class_for_check + " #answer_best")).to be_checked
      expect(page).to have_field("answer_best", checked: true, count: 1)
    end
  end

end
