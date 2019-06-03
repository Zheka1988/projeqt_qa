require 'rails_helper'

feature 'User can create answer', %q{
  being on the question page,
  can write the answer to the question
} do

  given(:user) { create(:user) }
  given(:question) { create :question, author: user }

  describe 'Authenticated user tries' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'create answer', js: true do
      expect(page).to have_content 'Show question'
      expect(page).to have_content 'MyText'
      expect(page).to have_content 'MyString'

      fill_in 'Body', with: 'answer answer answer'
      click_on 'Reply'

      within '.answers' do
        expect(page).to have_content 'answer answer answer'
      end
    end

    scenario 'create answer with errors', js: true do
      click_on 'Reply'

      expect(page).to have_content "Body can't be blank"
    end

    scenario 'give answer with attached one/some files ', js: true do
      fill_in 'Body', with: 'answer answer answer'

      attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Reply'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

  end

  scenario 'Unauthenticated user tries to create answer' do
    visit question_path(question)
    click_on 'Reply'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
