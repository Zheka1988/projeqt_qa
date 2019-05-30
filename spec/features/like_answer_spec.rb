require 'rails_helper'

feature 'Author the question can shoose the best answer', %q{
  being on the question page,
  author can shoose, which answer is better
} do

  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:reward) { create :reward, question: question }
  given!(:answer) { create_list(:answer, 3, question: question, author: user) }

  scenario 'Unauthenticated user can not shoose the best answer' do
    visit questions_path(question)

    expect(page).to_not have_field('Best')
  end

  describe 'Authenticated user' do

    scenario 'author question, can choose best Answer', js: true do
      sign_in(user)
      question.reward.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'reward.png')), filename: 'reward.png', content_type: 'image/png')

      visit question_path(question)

      id_for_check = 'tr#record-answer-' + Answer.second.id.to_s

      within id_for_check do
        click_on 'Best Answer'
      end

      expect(page).to have_css('tbody:first-child', text: Answer.second.body )
    end

    scenario 'not author question, can not shoose best answer' do
      sign_in other_user
      question.reward.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'reward.png')), filename: 'reward.png', content_type: 'image/png')
      visit question_path(question)

      expect(page).to have_no_link('Best Answer')
    end
  end

end
