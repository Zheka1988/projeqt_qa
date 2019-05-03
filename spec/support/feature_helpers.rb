module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def user_create
    User.create(email: "mail_user@mail.ru", password: "12345678", password_confirmation: "12345678")
  end
end
