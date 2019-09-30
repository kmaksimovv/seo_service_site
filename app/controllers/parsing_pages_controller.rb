class ParsingPagesController < ApplicationController
  def parsing_page
    @page  = Page.find(params[:id])
    @parser = @page.parser
  end
end
