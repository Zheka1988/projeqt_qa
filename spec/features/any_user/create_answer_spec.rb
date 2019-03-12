require 'rails_helper'

feature 'Any user can', %q{
  being on the question page,
  can write the answer to the question
} do
  given(:question) { create(:question) }

  scenario 'create answer' do
    visit question_path(question)
    expect(page).to have_content 'Show question'
    expect(page).to have_content 'MyText'
    expect(page).to have_content 'MyString'

    fill_in 'Body', with: 'answer answer answer'
    click_on 'Reply'

    expect(page).to have_content 'Your answer has been published.'
    expect(page).to have_content 'answer answer answer'
  end

end
