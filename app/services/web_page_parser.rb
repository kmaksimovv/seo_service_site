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
                  :keywords,
                  :tag_h_one,
                  :count_tags

    def initialize(url)
      @doc = Nokogiri::HTML(open(url))
      @count_tags = {}
      page_detail_info
    end

    def page_detail_info
      self.title = page_title
      self.charset = page_charset
      self.compatible = page_compatible
      self.viewport = page_viewport
      self.description = page_description
      self.keywords = page_keywords
      self.language = page_language
      self.tag_h_one = page_tag_h_one
      page_count_tags
    end

    private

    def page_title
      @doc.title
    rescue NoMethodError
    end

    def page_charset
      @doc.at('meta[charset]').values.join
    rescue NoMethodError
    end

    def page_compatible
      @doc.at('meta[http-equiv]').values.join(',')
    rescue NoMethodError
    end

    def page_viewport
      @doc.at('meta[name = "viewport"]').values.join(',')
    rescue NoMethodError
    end

    def page_description
      @doc.at('meta[name = "description"]').values.second
    rescue NoMethodError
    end

    def page_language
      @doc.children[1].attribute('lang').value
    rescue NoMethodError
    end

    def page_keywords
      @doc.at('meta[name = "keywords"]').values.last
    rescue NoMethodError
    end

    def page_tag_h_one
      @doc.at_css('h1').children.text
    rescue NoMethodError
    end

    def page_count_tags
      tags = %w[div h1 h2 h3 h4 h5 h6 p ul a form table br]
      tags.each do |tag|
        self.count_tags[tag] = @doc.css(tag).size
      end
    end
  end
end
