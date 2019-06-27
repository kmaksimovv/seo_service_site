class ParseSitemapJob < ApplicationJob
  queue_as :default

  def perform(site)
    site.sitemap
    site.save_urls
  end
end
