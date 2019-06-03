class SitesController < ApplicationController
  def index
    @sites = Site.order(created_at: :desc).limit(10)
    @site = Site.new
  end

  def create
    @site = current_user.sites.new(params.require(:site).permit(:domain))
    @site.set_https_status(HttpsStatus.new(@site.domain).https?)

    if @site.save
      redirect_to sites_path, notice: 'domain added' if @site
    else
      redirect_to sites_path
    end
  end

  def destroy
    Site.find(params[:id]).destroy
  end
end
