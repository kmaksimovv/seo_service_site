class SitemapFilesController < ApplicationController
  before_action :find_site

  def show
    @sparser = SitemapParser.new(@site.domain)
  end

  private

  def find_site
    @site = Site.find(params[:site_id])  
  end
end
