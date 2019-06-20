class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string :domain
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    add_index :sites, :domain, unique: true
  end
end
