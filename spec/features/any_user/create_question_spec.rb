require 'rails_helper'

feature 'Any user can', %q{create question } do

  scenario 'create question' do
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'
    click_on 'Ask'

    expect(page).to have_content 'Your question successfully created.'
    expect(page).to have_content 'Text question'
    expect(page).to have_content 'text text text'
  end

end
