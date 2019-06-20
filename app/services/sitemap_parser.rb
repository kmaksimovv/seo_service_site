require 'nokogiri'
require 'uri'
require 'set'
require 'open-uri'
require 'uri'
require 'net/http'

class SitemapParser
  attr_reader :domain, :url, :url_http_sitemap, :url_https_sitemap, :url_http_www_sitemap, :url_https_www_sitemap, :robots_sitemap_lists

  def initialize(domain)
    @domain = domain
    @url = URI.parse("http://#{domain}")
    @url_http_sitemap = URI.join(url, 'sitemap.xml')
    @url_https_sitemap = URI.join(URI.parse("https://#{domain}"), 'sitemap.xml')
    @url_http_www_sitemap = URI.join(URI.parse("http://www.#{domain}"), 'sitemap.xml')
    @url_https_www_sitemap = URI.join(URI.parse("https://www.#{domain}"), 'sitemap.xml')
  end

  def urls
    if check_default_sitemap
      read_xml_sitemap(check_default_sitemap)
      find_urls
    end
  end

  def robots_sitemap
    @robots_sitemap_path_list ||= open(URI.join(@url, 'robots.txt')).read.scan(/\s*sitemap:\s*([^\r\n]+)\s*$/i).flatten!.uniq
    handle_nested_sitemaps(@robots_sitemap_path_list)
  end

  def handle_nested_sitemaps(robots_sitemap_path_list=[])
    robots_sitemap_path_list.map do |path|
      path_io = open(path)
      sitemap_data = Nokogiri::HTML(path)
      nested_sitemaps = sitemap_data.xpath("//sitemapindex/sitemap/loc")
      nested_sitemaps.map(&:text).flatten
    end
  end

  private

  def check_default_sitemap
    return url_http_sitemap if Net::HTTP.get_response(@url_http_sitemap).code == '200'
    return url_https_sitemap if Net::HTTP.get_response(@url_https_sitemap).code == '200'
    return uri_http_www_sitemap if Net::HTTP.get_rdesponse(@uri_http_www_sitemap).code == '200'
    return uri_https_www_sitemap if Net::HTTP.get_response(@uri_https_www_sitemap).code == '200'
  rescue StandardError
    false
  end

  def read_xml_sitemap(sitemap_file)
    @sitemap ||= Nokogiri::XML(open(sitemap_file, &:read))
  end

  def find_urls
    @sitemap.search('url').map { |url| url.at('loc').content }
  end
end
