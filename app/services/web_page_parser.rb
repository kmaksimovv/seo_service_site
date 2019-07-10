module WebPageParser
  require 'nokogiri'
  require 'open-uri'

  class PageParser
    attr_reader :doc
    attr_accessor :title,
                  :charset,
                  :compatible,
                  :viewport,
                  :description,
                  :language,
                  :keywords

    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
      page_detail_info
    end

    def page_detail_info
      self.title = page_title
      self.charset = page_charset
      self.compatible = page_compatible
      self.viewport = page_viewport
      self.page_description = page_description
      self.language = page_language
      self.keywords = page_keywords
    rescue StandardError
    end

    private

    def page_title
      @doc.title
    end

    def page_charset
      @doc.at('meta[charset]').values.join
    end

    def page_compatible
      @doc.at('meta[http-equiv]').values.join(',')
    end

    def page_viewport
      @doc.at('meta[name = "viewport"]').values.join(',')
    end

    def page_description
      @doc.at('meta[name = "description"]').values.second
    end

    def page_language
      @doc.children[1].attribute('lang').value
    end

    def page_keywords
      @doc.at('meta[name = "keywords"]').values.last
    end
  end
end
