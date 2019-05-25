require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an questions'author
  i'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { "https://gist.github.com/Zheka1988/1fface642803fb09e9d82ec4ccea17f5.js" }

  scenario 'user can add linsk to question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url


    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url
  end

end
