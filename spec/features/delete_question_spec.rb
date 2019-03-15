require 'rails_helper'

feature 'User can delete questions', %q{
  Registered user can delete his question
} do

  given(:user) { create(:user) }
  given!(:question) { create :question, author: user }

  scenario 'delete question' do
    sign_in(user)
    visit questions_path
    click_on 'Delete'

    expect(page).to have_content 'Your question has been deleted.'
    expect(page).to have_no_content 'MyText'
  end

  describe 'button for Delete question is not visible' do
    given(:other_user) { create(:user) }
    given!(:question) { create :question, author: other_user }

    scenario 'if the user is not the author' do
      sign_in(user)
      visit questions_path
      expect(page).to have_no_link('Delete')
    end

    scenario 'If the user is not logged in' do
      visit questions_path
      expect(page).to have_no_link('Delete')
    end
  end

end
