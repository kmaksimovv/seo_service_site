# frozen_string_literal: true

module ApplicationHelper
  def count_pages(site)
    site.sitemap_file.pages.count
  rescue
    0
  end

  def format_date(date, options = { time: true })
    format = options[:time] ? '%d-%m-%Y %H:%M' : '%d.%m.%Y'
    date&.strftime(format)
  end
  def truncate(string, max)
    string.length > max ? "#{string[0...max]}..." : string
  end
end
