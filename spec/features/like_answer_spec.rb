require 'rails_helper'

feature 'Author the question can shoose the best answer', %q{
  being on the question page,
  author can shoose, which answer is better
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unauthenticated user can not shoose the best answer' do
    visit questions_path(question)

    expect(page).to_not have_field('Best')
  end

  describe 'Authenticated user' do
    scenario 'can choose best Answer', js: true do
      sign_in user

      visit question_path(question)
      check "Best"

      expect(page).to have_field('answer_best', checked: true)

   end
  end

end
