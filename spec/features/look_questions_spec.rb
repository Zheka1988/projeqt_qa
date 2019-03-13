require 'rails_helper'

feature 'Any user can look questions', %q{
  Any user see the list of questions
} do
  given(:user) { user_create }

  scenario 'look list questions' do
    FactoryBot.create_list(:question, 3, author: user)
    visit questions_path

    expect(page).to have_content 'List of all questions'
    expect(page).to have_content  'MyString', count: 3
    expect(page).to have_content 'MyText'
  end

end
