require 'rails_helper'

feature 'Any user can look answers', %q{
  Any user can look question and answers to it
} do
  given(:user) { user_create }
  given(:question) { create :question, author: user }

  scenario 'look list answers' do
    FactoryBot.create_list(:answer, 3, question: question, author: user)
    visit question_path(question)

    expect(page).to have_content 'Show question'
    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
    expect(page).to have_content 'Show answers'
    expect(page).to have_content 'MyTextAnswer', count: 3
  end
end
