class SitesController < ApplicationController
  def index
    @sites = Site.order(created_at: :desc)
    @site = Site.new
  end

  def create
    @site = current_user.sites.create(params.require(:site).permit(:domain))
  end

  def destroy
    Site.find(params[:id]).destroy
  end
end
