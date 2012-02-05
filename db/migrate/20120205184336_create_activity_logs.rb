class CreateActivityLogs < ActiveRecord::Migration
  def self.up
    create_table :activity_logs do |t|
      t.string :ip_address
      t.text :note
      t.string :activity

      t.timestamps
    end
  end

  def self.down
    drop_table :activity_logs
  end
end
