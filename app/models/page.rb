class Page < ApplicationRecord
  belongs_to :sitemap_file

  def to_s
    url
  end
end
