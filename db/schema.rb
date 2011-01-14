# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110113230951) do

  create_table "custom_pages", :force => true do |t|
    t.string   "permalink"
    t.string   "title"
    t.text     "content"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_pages", ["permalink", "locale"], :name => "index_custom_pages_on_permalink_and_locale", :unique => true

  create_table "days", :force => true do |t|
    t.date     "date",       :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title",                         :null => false
    t.text     "content",                       :null => false
    t.string   "locale",     :default => "en",  :null => false
    t.boolean  "published",  :default => false, :null => false
    t.string   "permalink",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["permalink", "locale"], :name => "index_posts_on_permalink_and_locale", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                               :default => false
    t.string   "default_location"
    t.string   "default_locale"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  add_foreign_key "days", ["user_id"], "users", ["id"], :name => "days_user_id_fkey"

end
