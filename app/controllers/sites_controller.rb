class SitesController < ApplicationController
  def index
    @sites = Site.order(created_at: :desc).limit(10)
  end

  def create
    @site = current_user.sites.new(params.require(:site).permit(:domain))
    if @site.save
      redirect_to sites_path, notice: 'domain added'
    else
      redirect_to sites_path
    end
  end

  def show
    @site = Site.find(params[:id])
    @checkdomain = CheckDomain.new(@site.domain)
  end
end
