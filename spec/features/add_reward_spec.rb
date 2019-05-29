require 'rails_helper'

feature 'User can add reward for best to answer on question', %q{
  In order to appoint reward from best answer
  As an question author
  i'd like to be able to add reward
} do

  given(:user) { create(:user) }
  # given(:question) { create :question, author: user }
  # given(:reward) { "#{Rails.root}/app/assets/reward.png" }

  scenario 'user can add reward' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Text question'
    fill_in 'Body', with: 'text text text'

    fill_in 'name reward', with: 'My reward'
    attach_file 'File', "#{Rails.root}/app/assets/images/reward.png"

    click_on 'Ask'

    expect(page).to have_content 'My reward'
    # expect(page).to have_css("img[src='/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBDUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--e9cbad16f411d90b9211a2993dca8bdf70a43c2b/reward.png']")
    #проверка наличия картинки
  end

end
