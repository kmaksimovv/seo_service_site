class SitemapFilesController < ApplicationController
  before_action :find_site

  def show
    @sitemap_file = @site.sitemap_file
  end

  private

  def find_site
    @site = Site.find(params[:site_id])  
  end
end
