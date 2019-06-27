class RobotsController < ApplicationController
  def robot
    @site = Site.find(params[:site_id])
    @robots = RobotsTxt.new(@site.domain).read
    if @robots
      render plain: @robots
    else
      render plain: 'File robots.txt was not found!'
    end
  end
end
