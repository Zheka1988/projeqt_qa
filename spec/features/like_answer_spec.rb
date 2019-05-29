require 'rails_helper'

feature 'Author the question can shoose the best answer', %q{
  being on the question page,
  author can shoose, which answer is better
} do

  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  # given!(:reward) {create :reward, question: question}#, file: "#{Rails.root}/app/assets/images/reward.png" }
  given!(:answer) { create_list(:answer, 3, question: question, author: user) }


  scenario 'Unauthenticated user can not shoose the best answer' do
    visit questions_path(question)

    expect(page).to_not have_field('Best')
  end

  describe 'Authenticated user' do
    scenario 'author question, can choose best Answer', js: true do
      sign_in(user)
      visit questions_path
      click_on 'Ask question'

      fill_in 'Title', with: 'Text question'
      fill_in 'Body', with: 'text text text'

      fill_in 'name reward', with: 'My reward'
      attach_file 'File', "#{Rails.root}/app/assets/images/reward.png"

      click_on 'Ask'
      visit question_path(question)

      fill_in 'Body', with: 'answer answer answer'
      click_on 'Reply'
      visit question_path(question)

      id_for_check = 'tr#record-answer-' + Answer.second.id.to_s

      expect(page).to have_link('Best Answer')

      within id_for_check do
        click_on 'Best Answer'
      end

      expect(page).to have_css('tbody:first-child', text: Answer.second.body )
    end

    scenario 'not author question, can not shoose best answer' do
      sign_in other_user

      visit question_path(question)

      expect(page).to have_no_link('Best Answer')

    end
  end

end
