module WebPageParser
  require 'nokogiri'
  require 'open-uri'

  class PageParser
    attr_reader :doc

    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
    end

    def title
      @doc.title
    end
  end
end
