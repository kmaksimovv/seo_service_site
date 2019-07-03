class ParsingPagesController < ApplicationController
  def parsing_page
    @page  = Page.find(params[:id])

    begin
      @parser = @page.parse
    rescue Errno::ENOENT => e
      flash.now[:error] = "No the file of the page there"
    rescue 
      render plain: 'Failed parse of this page!'
    end
  end
end
