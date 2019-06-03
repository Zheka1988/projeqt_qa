require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an questions'author
  i'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:google) { "https://google.ru" }

  scenario 'user can add link to question', js: true do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My link'
    fill_in 'Url', with: google
    click_on 'Ask'

    expect(page).to have_link 'My link', href: google
  end

  scenario 'user can add several links to question', js: true do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My link'
    fill_in 'Url', with: google
    click_on 'add link'

    within '.nested-fields:nth-of-type(2)' do
      fill_in 'Link name', with: 'My link'
      fill_in 'Url', with: google
    end

    click_on 'Ask'

    expect(page).to have_link 'My link', href: google, count: 2
  end

end
