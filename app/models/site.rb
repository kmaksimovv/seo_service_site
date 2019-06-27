class Site < ApplicationRecord
  belongs_to :user
  has_one :sitemap_file, dependent: :destroy

  validates :domain, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true

  after_create :parse_sitemap_job

  def sitemap
    sparser = SitemapParser.new(domain)
    create_sitemap_file(path: sparser.sitemap_path)
  end

  def save_urls
    sparser = SitemapParser.new(domain)
    urls = sparser.urls
    urls.each do |url|
      sitemap_file.pages.create(url: url)
    end
  end

  private

  def parse_sitemap_job
    ParseSitemapJob.perform_later(self)
  end
end
