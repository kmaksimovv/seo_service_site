require 'net/https'
require 'uri'

class HttpsStatus
  def initialize(domain)
    @domain = domain
  end

  def https?
    http = Net::HTTP.new(@domain, 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    code = http.request(Net::HTTP::Get.new('/')).code
    return true if code == '200' || code == '301'
  rescue Exception 
    false
  end
end
