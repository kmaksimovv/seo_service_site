class Site < ApplicationRecord
  belongs_to :user
  has_one :sitemap_file, dependent: :destroy 

  validates :domain, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true

  after_create :parse_sitemap_job

  private

  def parse_sitemap_job
    ParseSitemapJob.perform_later(self)
  end
end
