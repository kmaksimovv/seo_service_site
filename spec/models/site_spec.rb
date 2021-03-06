require 'rails_helper'

RSpec.describe Site, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_one(:sitemap_file).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:domain) }
    it { should validate_uniqueness_of(:domain).case_insensitive }
  end
end
