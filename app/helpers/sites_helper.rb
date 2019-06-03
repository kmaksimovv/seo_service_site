module SitesHelper
  def view_https_status(status)
    if status
      "YES"
    else
      "NOT"
    end
  end
end
