require 'rails_helper'

RSpec.describe SitemapFile, type: :model do
  describe 'Associations' do
    it { should belong_to(:site) }
    it { should have_many(:pages).dependent(:destroy) }
  end
end
