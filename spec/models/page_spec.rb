require 'rails_helper'

RSpec.describe Page, type: :model do
  describe 'Associations' do
    it { should belong_to(:sitemap_file) }
  end
end
