require 'open-uri'
require 'uri'

class RobotsTxt
  attr_reader :path

  def initialize(domain)
    @path = URI.join(URI.parse("http://#{domain}"), 'robots.txt')
  end

  def read
    raw_data = open(@path) { |f| f.read }
  rescue StandardError
    raw_data = nil
    return if raw_data.nil?
    raw_data
  end
end
