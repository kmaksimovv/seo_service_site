class Page < ApplicationRecord
  belongs_to :sitemap_file

  def to_s
    url
  end

  def parser
    WebPageParser::PageParser.new(url)
  end
end
