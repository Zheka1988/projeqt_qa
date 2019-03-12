require 'rails_helper'

feature 'Any user can', %q{
  see the list of questions and answers to them
} do
  given(:question) { create(:question) }
  given!(:answer) { create :answer, question: question }

  scenario 'look list questions' do
    visit questions_path
    expect(page).to have_content 'List of all questions'
    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
  end

  scenario 'look question and his answers' do
    visit question_path(question)
    expect(page).to have_content 'Show question'
    expect(page).to have_content 'MyString'
    expecr(page).to have_content 'MyText'

    expect(page).to have_content 'Show answers'
    expect(page).to have_content 'MyTextAnswer'
  end

end
