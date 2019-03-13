require 'rails_helper'

feature 'User can create answer', %q{
  being on the question page,
  can write the answer to the question
} do
  #Использовал данную запись т.к. FactoryBot помещает в тестовую базу данных usera, которая не очищается между тестами.
  #и как следствие выходит ошибка: "Validation failed: Email has already been taken"
  given(:user) { user_create }
  given(:question) { create :question, author: user }

  describe 'Authenticated user tries' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'create answer' do
      expect(page).to have_content 'Show question'
      expect(page).to have_content 'MyText'
      expect(page).to have_content 'MyString'

      fill_in 'Body', with: 'answer answer answer'
      click_on 'Reply'

      expect(page).to have_content 'Your answer has been published.'
      expect(page).to have_content 'answer answer answer'
    end

    scenario 'create answer with errors' do
      click_on 'Reply'

      expect(page).to have_content 'Your answer has not been published.'
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to create answer' do
    visit question_path(question)
    click_on 'Reply'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
