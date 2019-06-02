require 'rails_helper'

feature 'Any user can sign up' do
  scenario 'with valid email and password' do
    sign_up_with 'user1@test.com', '12345678', '12345678'

    open_email 'user1@test.com'

    current_email.click_link 'Confirm my account'
    expect(page).to have_content 'Your email address has been successfully confirmed.'
  end

  scenario 'with invalid email' do
    sign_up_with 'user1', '12345678', '12345678'

    expect(page).to have_content 'Sign up'
  end

  scenario 'with blank password' do
    sign_up_with 'user1@test.com', '', ''

    expect(page).to have_content 'Password can\'t be blank'
  end

  scenario 'Password confirmation does not match password' do
    sign_up_with 'user1@test.com', '12345678', '1234'

    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end
end
