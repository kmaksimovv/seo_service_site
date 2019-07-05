module WebPageParser
  require 'nokogiri'
  require 'open-uri'

  class PageParser
    attr_reader :doc

    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
    end

  # high tags
    def title
      @doc.title
    end

    def charset
      @doc.at('meta[charset]')&.values&.join
    end

    def compatible
      @doc.at('meta[http-equiv]').values.join(',')
    end

    def viewport
      @doc.at('meta[name = "viewport"]').values.join(',')
    end

    def description
      @doc.at('meta[name = "description"]').values.second
    end

    def language_tag
      @doc.children[1].attribute('lang').value
    end

    # low tags
  end
end
