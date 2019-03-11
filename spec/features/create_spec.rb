require 'rails_helper'

feature 'User can create/delete question/answer', %q{
    In order to get answer from a communnity
    As an authenticated user
    I'd like to be able to ask the question and give an answer.
    And also be able to delete your question/answer
} do
  given(:user) { create(:user) }
  given(:question) { create :question, author: user }
  given!(:answer) { create :answer, question: question, author: user }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end

    scenario 'asks a question' do
      fill_in 'Title', with: 'Text question'
      fill_in 'Body', with: 'text text text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Text question'
      expect(page).to have_content 'text text text'
    end

    scenario 'asks a question with errors' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'give answer' do

      visit question_path(question)
      fill_in 'Body', with: 'body answer'
      click_on 'Reply'

      expect(page).to have_content 'Your answer has been published.'
      expect(page).to have_content 'body answer'
    end

    scenario 'give answer with errors' do
      visit question_path(question)
      click_on 'Reply'
      expect(page).to have_content 'Your answer has not been published.'
    end

    scenario 'delete question' do
      visit questions_path
      click_on 'Delete'

      expect(page).to have_content 'Your question has been deleted.'
    end

    scenario 'delete answer' do
      visit question_path(question)
      click_on 'Delete'

      expect(page).to have_content 'Your answer has been deleted.'
    end
  end

  scenario 'Unauthenticated user tries to ask a question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
