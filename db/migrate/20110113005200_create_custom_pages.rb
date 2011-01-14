class CreateCustomPages < ActiveRecord::Migration
  def self.up
    create_table :custom_pages do |t|
      t.string :permalink
      t.string :title
      t.text :content
      t.string :locale

      t.timestamps
    end
    add_index :custom_pages, [:permalink, :locale], :unique => true
  end

  def self.down
    drop_table :custom_pages
  end
end
