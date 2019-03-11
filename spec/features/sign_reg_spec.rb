require 'rails_helper'

feature 'User can sign in', %q{
 Sign in,
 Log out,
 Register in the system
} do
  given(:user) { create(:user) }

  scenario 'registered user tries sign in system' do
    sign_in(user)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'unregistered user tries sign in system' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  scenario 'logged in user can logout system'  do
    sign_in(user)
    visit questions_path
    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'register in system' do
    visit new_user_registration_path

    fill_in 'Email', with: 'new_user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

end
