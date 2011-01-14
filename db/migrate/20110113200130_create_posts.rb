class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.string :locale, :null => false, :default => "en"
      t.boolean :published, :null => false, :default => false
      t.string :permalink, :null => false

      t.timestamps
    end
    add_index :posts, [:permalink, :locale], :unique => true
  end

  def self.down
    drop_table :posts
  end
end
