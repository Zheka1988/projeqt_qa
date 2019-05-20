require 'rails_helper'

feature 'User can edit his question', %q{
  To correct errors
  As the author of the question
  I would like to be able to edit my question
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  scenario 'Unauthenticated user can not edit question' do
    visit questions_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    scenario 'edits his question', js: true do
      sign_in user
      visit questions_path(question)

      within '.questions' do
        click_on 'Edit'
        fill_in 'Your Question', with: 'edited question'
        click_on 'Save'

        expect(page).to_not have_content question.body
        expect(page).to have_content 'edited question'
        expect(page).to_not have_selector 'textarea'
      end
    end
    scenario 'edits his question with errors', js: true do
      sign_in user
      visit questions_path(question)
      click_on 'Edit'

      within '.questions' do
        fill_in 'Your Question', with: ""

        click_on 'Save'
      end

      expect(page).to have_content "Body can't be blank"
    end
  end

  describe "user can't edit question if not author" do
    given(:other_user) { create(:user) }
    given!(:question) { create :question, author: other_user }

    scenario 'if the user is not the author' do
      sign_in(user)
      visit questions_path(question)

      expect(page).to_not have_content 'Edit'
    end
  end
end
