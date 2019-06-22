require 'nokogiri'
require 'uri'
require 'set'
require 'open-uri'
require 'uri'
require 'net/http'

class SitemapParser
  attr_reader :domain, :url, :url_http_sitemap, :url_https_sitemap, :url_http_www_sitemap, :url_https_www_sitemap, :robots_sitemap_path_list, :sitemaps

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
  rescue StandardError
    nil
  end

  def handle_nested_sitemaps(robots_sitemap_path_list = [])
    nested_sitemap = robots_sitemap_path_list.map do |path|
      path_io = open(path)
      sitemap_data = Nokogiri::HTML(path_io).xpath('//sitemapindex/sitemap/loc').map(&:text)
    end

    @sitemaps = nested_sitemap.flatten!
    @sitemaps

    urls = @sitemaps.map do |sitemap|
      unpack_sitemap = load_sitemap(sitemap)
      Nokogiri::XML(unpack_sitemap).search('url').map { |url| url.at('loc').content }
    end
    urls.flatten!
  end

  def load_sitemap(url = nil)
    sitemap_io = open(url)
    Zlib::GzipReader.new(sitemap_io)
  rescue StandardError
    nil
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