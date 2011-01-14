class UsersAddDefualts < ActiveRecord::Migration
  def self.up
    add_column :users, :default_location, :string
    add_column :users, :default_locale, :string
  end

  def self.down
    remove_column :users, :default_location
    remove_column :users, :default_locale
  end
end
