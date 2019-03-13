require 'rails_helper'

feature 'User can delete questions', %q{
  Registered user can delete his question
} do

  given(:user) { user_create }
  given!(:question) { create :question, author: user }

  scenario 'delete question' do
    sign_in(user)
    visit questions_path
    click_on 'Delete'

    expect(page).to have_content 'Your question has been deleted.'
    expect(page).to have_no_content 'MyText'
  end

end