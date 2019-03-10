require 'rails_helper'

feature 'Any user can', %q{
  Ask a question to get an answer,
  give an answer yourself
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

  scenario 'look list questions' do
    visit questions_path
    expect(page).to have_content 'List of all questions'
  end

  given(:question) { create(:question) }
  given(:answer) { create :answer, question: question }

  scenario 'being on the question page, can write the answer to the question' do
    visit question_path(question)
    expect(page).to have_content 'Show question'
    expect(page).to have_content 'MyText'
    expect(page).to have_content 'MyString'

    fill_in 'Body', with: 'answer answer answer'

    click_on 'Reply'

    expect(page).to have_content 'Your answer has been published.'
    expect(page).to have_content 'answer answer answer' # здесь выходит ошибка
    # ... expected to find text "answer answer answer" in...
    #т.к. в паршеле _answer не выводиться тело ответа, не пойму в чем причина?
  end

  scenario 'look question and his answers' do
    visit question_path(question)
    expect(page).to have_content 'Show question'
    expect(page).to have_content 'Show answers'
  end



  scenario 'user can sign in system'
  scenario 'user can sign out system'
  scenario 'user can register in system'

  scenario 'only authenticate user can create questions and answers'
  scenario 'author can delete own question or answer, but can not delete another question/answer'
end
