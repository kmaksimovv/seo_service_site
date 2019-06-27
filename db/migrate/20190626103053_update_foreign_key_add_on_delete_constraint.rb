class UpdateForeignKeyAddOnDeleteConstraint < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :pages, :sitemap_files
    add_foreign_key :pages, :sitemap_files, on_delete: :cascade
    remove_foreign_key :sitemap_files, :sites
    add_foreign_key :sitemap_files, :sites, on_delete: :cascade
    remove_foreign_key :sites, :users
    add_foreign_key :sites, :users, on_delete: :cascade
  end
end
