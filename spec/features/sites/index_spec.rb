require 'rails_helper'

feature 'Authenticated user can see a list of domains' do
  given(:user) { create(:user) }
  given!(:sites) { create_list(:site, 3, user: user) }

  describe 'Authenticated user' do
    background do
      sign_in user
      visit sites_path
    end

    scenario 'see list of domains' do
      visit sites_path

      sites.each do |site|
        expect(page).to have_content site.domain
      end
    end
  end
end
