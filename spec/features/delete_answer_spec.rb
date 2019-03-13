require 'rails_helper'

feature 'User can delete answer', %q{
  Registered user can delete his answer
} do

  given(:user) { create(:user) }
  given(:question) { create :question, author: user }
  given!(:answer) { create :answer, question: question, author: user }

  scenario 'delete answer if user logged' do
    sign_in(user)
    visit question_path(question)

    click_on 'Delete'

    expect(page).to have_content 'Your answer has been deleted.'
    expect(page).to have_no_content 'MyTextAnswer'
  end

end
