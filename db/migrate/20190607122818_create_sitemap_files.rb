class CreateSitemapFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :sitemap_files do |t|
      t.string :path
      t.belongs_to :site, index: { unique: true }, foreign_key: true
      t.timestamps
    end
  end
end
