require 'rails_helper'

feature 'User can delete questions and answers', %q{
  Registered user can delete his question or answer
} do

  given(:user) { create(:user) }
  given(:question) { create :question, author: user }
  given!(:answer) { create :answer, question: question, author: user }

  background do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
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
