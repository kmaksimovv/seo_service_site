class Site < ApplicationRecord
  belongs_to :user
  has_one :sitemap_file, dependent: :destroy 

  validates :domain, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true
end
