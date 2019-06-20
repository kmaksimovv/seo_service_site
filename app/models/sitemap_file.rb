class SitemapFile < ApplicationRecord
  belongs_to :site
  has_many :pages, dependent: :destroy
end
