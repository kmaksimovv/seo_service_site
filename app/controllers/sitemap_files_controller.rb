class SitemapFilesController < ApplicationController
  before_action :find_site

  def index
  end




  private

  def find_site
    @site = Site.find(params[:site_id])  
  end
end
