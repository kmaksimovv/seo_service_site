module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'почта', with: user.email
    fill_in 'пароль', with: user.password
    click_on 'войти'
  end

  def sign_up_with(email, password, password_confirmation)
    visit new_user_registration_path
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password_confirmation
    click_on 'Sign up'
  end
end
