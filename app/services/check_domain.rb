require 'net/https'
require 'net/http'
require 'uri'

class CheckDomain
  attr_reader :uri_http, :uri_https, :uri_http_www, :uri_https_www

  def initialize(domain)
    @domain = domain
    @uri_http = URI.parse("http://#{@domain}")
    @uri_https = URI.parse("https://#{@domain}")
    @uri_http_www = URI.parse("http://www.#{@domain}")
    @uri_https_www = URI.parse("https://www.#{@domain}")
  end

  def code(uri)
    request(uri)&.code
  end

  def message(uri)
    request(uri)&.message
  end

  def request(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.use_ssl = (uri.scheme == 'https')
    http.request(request)
  rescue Exception
    nil
  end
end
