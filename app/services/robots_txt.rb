require 'open-uri'

class RobotsTxt

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
    
    raw_data
  end
end

