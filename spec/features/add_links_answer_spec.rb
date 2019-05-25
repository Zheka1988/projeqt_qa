require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer author
  i'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:question) { create :question, author: user }
  given(:gist_url) { "https://gist.github.com/Zheka1988/1fface642803fb09e9d82ec4ccea17f5.js" }

  scenario 'user can add linsk to answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'answer answer answer'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Reply'

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end

end
