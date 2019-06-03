class AddColumnsToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :https_status, :boolean
    add_column :sites, :www_subdomain, :boolean
  end
end
