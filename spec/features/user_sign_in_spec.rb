require 'rails_helper'

feature 'User can sign in' do
  given(:user) { create(:user) }

  background { visit new_user_session_path }

  scenario 'Registered user tries to sign in' do
    sign_in user
    sleep 10
    expect(page).to have_content 'Вход в систему выполнен'
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'почта', with: 'wrong@test.com'
    fill_in 'пароль', with: '12345678'
    click_on 'войти'

    expect(page).to have_content 'Неправильный Email или пароль.'
  end
end
