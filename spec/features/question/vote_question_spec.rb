require 'rails_helper'
feature 'Any User can voiting for the any question', %q{
  In order to create rating,
  authorized user, but not author,
  can voite for the any question
} do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create :question, author: user }

  scenario 'Unauthenticated user can not edit question' do
    visit questions_path

    expect(page).to_not have_link 'Like'
    expect(page).to_not have_link 'Dizlike'
  end

  describe 'Authenticated user' do
    background do
      sign_in(other_user)

      visit questions_path
    end

    scenario 'Not author, can vote like for the question' do
      click_on 'Like'
      like = Question.all.first.like
      dis = Question.all.first.dislike

      expect(page).to have_content 'Your vote has been counted!'


      # expect(page).to have_content "#{like-dis}"
    end

    # scenario 'Not author, can vote dislike for the question' do

    # end

    # scenario 'Author, can not vote (like/Dislike) for the question' do

    # end

    # scenario 'Not author, can vote for the question, only once' do

    # end

  end
end
