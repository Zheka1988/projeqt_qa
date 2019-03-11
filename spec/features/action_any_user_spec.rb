require 'rails_helper'

feature 'Any user can', %q{
  Ask a question to get an answer,
  Give an answer yourself
} do

  given(:question) { create(:question) }
  given!(:answer) { create :answer, question: question }

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

  scenario 'look list questions' do
    visit questions_path
    expect(page).to have_content 'List of all questions'
  end

  scenario 'being on the question page, can write the answer to the question' do
    visit question_path(question)
    expect(page).to have_content 'Show question'
    expect(page).to have_content 'MyText'
    expect(page).to have_content 'MyString'

    fill_in 'Body', with: 'answer answer answer'
    click_on 'Reply'

    expect(page).to have_content 'Your answer has been published.'
    expect(page).to have_content 'answer answer answer'
  end

  scenario 'look question and his answers' do
    visit question_path(question)
    expect(page).to have_content 'Show question'
    expect(page).to have_content 'MyString'

    expect(page).to have_content 'Show answers'
    expect(page).to have_content 'MyTextAnswer'
  end

end
