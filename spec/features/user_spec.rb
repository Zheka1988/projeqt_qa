require 'rails_helper'

feature 'User can create question', %q{
  any_user can create question
} do

  scenario 'create question' do
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'
    click_on 'Ask'

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'Text question'
    expect(page).to have_content 'text text text'
  end

  scenario 'user can look list questions' do
    visit questions_path
    expect(page).to have_content 'List of all questions'
  end

  scenario 'user, being on the question page, can write the answer to the question'
  scenario 'user can look question and his answers'

  scenario 'user can sign in system'
  scenario 'user can sign out system'
  scenario 'user can register in system'

  scenario 'only authenticate user can create questions and answers'
  scenario 'author can delete own question or answer, but can not delete another question/answer'
end
