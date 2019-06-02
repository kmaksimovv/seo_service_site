require 'rails_helper'

feature 'Authentificated user can sign out' do
  given(:user) { create(:user) }

  scenario 'Logout' do
    sign_in user
    click_on 'Logout'

    expect(page).to have_content 'Signed out successfully.'
  end
end
