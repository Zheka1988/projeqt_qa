require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer author
  i'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:question) { create :question, author: user }
  given(:google) { "https://google.ru" }

  scenario 'user can add one link to answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'answer answer answer'

    fill_in 'Link name', with: 'My link'
    fill_in 'Url', with: google

    click_on 'Reply'
    within '.answers' do
      expect(page).to have_link 'My link', href: google
    end
  end

  scenario 'user can add several links to answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'answer answer answer'

    fill_in 'Link name', with: 'My link'
    fill_in 'Url', with: google

    click_on 'add link'

    within '.nested-fields:nth-of-type(2)' do
      fill_in 'Link name', with: 'My link'
      fill_in 'Url', with: google
    end
    click_on 'Reply'

    within '.answers' do
      expect(page).to have_link 'My link', href: google, count: 4
    end
  end

end
