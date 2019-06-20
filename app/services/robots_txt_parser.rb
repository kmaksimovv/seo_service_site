require 'open-uri'

class RobotsTxtParser
  attr_accessor :sitemaps

  def read(path)
    begin
      if path.include?("://")
        raw_data = open(path)
      else
        raw_data = File.open(path)
      end
    rescue
      raw_data = nil
    end
    return if raw_data == nil
    
    find_sitemap(raw_data)
  end

  def find_sitemap(raw_data)
    @sitemaps = Array.new

    raw_data.each_line do |line|
      if line.match(/^sitemap:/i)
        @sitemaps.push line.gsub(/^sitemap:/i, "").strip
      end
    end
  end
end
