require 'rails_helper'

feature 'User can delete any attach file for answer', %q{
  Registered user can delete attach file his answer
} do

  given(:user) { create(:user) }
  given!(:other_user) { create (:user) }
  given!(:question) { create :question, author: user }
  given!(:answer) { create :answer ,question: question, author: user }
  given(:google) { "https://google.ru" }

# 'тот тест не проходит, потому что ссылки отображаеться 2 раза'
  scenario 'delete link if user author the answer', js: true do
    sign_in user
    visit question_path(question)

    within '.answers' do
      click_on 'Edit'
      click_on 'add link'
      fill_in 'Link name', with: 'My link'
      fill_in 'Url', with: google

      click_on 'Save'
    end

    visit question_path(question)
    within '.answers' do
      click_on 'Delete Link'
    end

    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_link 'My link', href: google
  end


  scenario 'delete link if user not author the answer', js: true do
    sign_in user
    visit question_path(question)

    within '.answers' do
      click_on 'Edit'
      click_on 'add link'
      fill_in 'Link name', with: 'My link'
      fill_in 'Url', with: google

      click_on 'Save'
    end

    click_on 'Logout'
    sign_in other_user
    visit question_path(question)

    expect(page).to_not have_link 'Delete Link'
  end

end
