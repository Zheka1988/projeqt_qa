require 'rails_helper'

feature 'User can delete answer', %q{
  Registered user can delete his answer
} do

  given(:user) { create(:user) }
  given(:question) { create :question, author: user }
  given!(:answer) { create :answer, question: question, author: user }

  scenario 'delete answer if user logged', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete'

    page.driver.browser.switch_to.alert.accept
    expect(page).to have_no_content 'MyTextAnswer'
  end

  describe 'button for Delete answer is not visible' do
    given(:other_user) { create(:user) }
    given!(:answer) { create :answer, question: question, author: other_user }

    scenario 'if the user is not the author', js: true do
      sign_in(user)

      visit question_path(question)
      expect(page).to have_no_link('Delete')
    end

    scenario 'If the user is not logged in', js: true do
      visit question_path(question)
      expect(page).to have_no_link('Delete')
    end
  end

end

