class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.date :date, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :days
  end
end
