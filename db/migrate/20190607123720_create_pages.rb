class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :url
      t.belongs_to :sitemap_file, foreign_key: true
      
      t.timestamps
    end
  end
end
