require 'rails_helper'

feature 'User can add reward for best to answer on question', %q{
  In order to appoint reward from best answer
  As an question author
  i'd like to be able to add reward
} do

  given(:user) { create(:user) }
  given(:question) { create :question, author: user }
  given(:reward) { "#{Rails.root}/app/assets/reward.png" }

  scenario 'user can add reward' do
    sign_in(user)
    visit question_path(question)

    fill_in 'name reward', with: 'My reward'
    fill_in 'path', with: reward

    click_on 'Ask'
    expect(page).to have_content 'My reward'
    #проверка наличия картинки
  end

end
