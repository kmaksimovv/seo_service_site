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
    return unless raw_data
    raw_data
  end
end
