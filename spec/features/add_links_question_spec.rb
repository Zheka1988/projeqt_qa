require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an questions'author
  i'd like to be able to add links
} do

  given(:user) { create(:user) }
  # given(:gist_url) { "https://gist.github.com/Zheka1988/1fface642803fb09e9d82ec4ccea17f5.js" }
  given(:google) { "https://google.ru" }
  scenario 'user can add linsk to question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My link'
    fill_in 'Url', with: google


    click_on 'Ask'
    # save_and_open_page
    expect(page).to have_link 'My link', href: google

    # expect(page).to have_link 'My gist', href: gist_url
    # within '.links' do #link-'+ Link.first.id.to_s do
    #   expect(page).to have_selector (:css 'script', visible: false, count: 1) #"<script src='https://gist.github.com/Zheka1988/1fface642803fb09e9d82ec4ccea17f5.js'></script>")
    # end
    # all('script').find { |s| s[:src].nil? }.count.should_not be(0)
  end

# "<script src='https://gist.github.com/Zheka1988/1fface642803fb09e9d82ec4ccea17f5.js'></script>"

end
