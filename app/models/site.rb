class Site < ApplicationRecord
  belongs_to :user
  has_many :sitemap_pages

  validates :domain, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true
end
