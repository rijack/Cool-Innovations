# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120827144422) do

  create_table "attachments", :force => true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "attachments", ["attachable_type", "attachable_id"], :name => "index_attachments_on_attachable_type_and_attachable_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.text     "payment_instructions"
    t.text     "shipping_instructions"
    t.text     "special_instructions"
  end

  create_table "comments", :force => true do |t|
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "name"
    t.integer  "sample_line_id"
    t.string   "customer_name"
    t.string   "contact_name"
    t.text     "address"
    t.text     "shipping_account_info"
    t.text     "comment"
    t.string   "ancestry"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "hardware_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "sort_priority", :default => 10000
  end

  create_table "hardwares", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.text     "comment"
    t.text     "vendor_name"
    t.text     "pricing_i"
    t.text     "pricing_history"
    t.integer  "hardware_category_id",    :default => 1
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "order_line_process_statuses", :force => true do |t|
    t.integer  "order_line_id"
    t.integer  "part_process_id"
    t.string   "status"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "order_line_priority", :default => 10000
    t.integer  "user_id"
    t.integer  "user_priority",       :default => 99
    t.text     "comment"
  end

  add_index "order_line_process_statuses", ["order_line_id"], :name => "index_order_line_process_statuses_on_order_line_id"
  add_index "order_line_process_statuses", ["part_process_id"], :name => "index_order_line_process_statuses_on_part_process_id"

  create_table "order_lines", :force => true do |t|
    t.integer  "order_id"
    t.integer  "part_id"
    t.date     "due_date"
    t.integer  "quantity"
    t.text     "comment"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.string   "status",                                           :default => "pending"
    t.date     "ship_date"
    t.decimal  "price",              :precision => 8, :scale => 4
    t.integer  "shipping_method_id"
    t.date     "actual_ship_date"
    t.integer  "line_number"
    t.string   "tracking_number"
    t.string   "color",                                            :default => "d-white"
    t.integer  "setup_cost"
  end

  create_table "orders", :force => true do |t|
    t.string   "purchase_order"
    t.integer  "client_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "part_process_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "sort_priority", :default => 10000
  end

  create_table "part_processes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "part_process_category_id", :default => 1
  end

  create_table "parts", :force => true do |t|
    t.text     "description"
    t.string   "part_number"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "required_hardwares", :force => true do |t|
    t.integer  "part_id"
    t.integer  "hardware_id"
    t.integer  "quantity"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "required_processes", :force => true do |t|
    t.integer  "part_id"
    t.integer  "part_process_id"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "required_process_priority", :default => 10000
  end

  create_table "sample_lines", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "part_id"
    t.integer  "quantity"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "new_part_number"
  end

  create_table "shipping_methods", :force => true do |t|
    t.string   "name"
    t.string   "duration"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stations", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.text     "notes"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "priority",        :default => 99
    t.string   "station_display", :default => "true"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "type"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "status",              :default => "user"
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "station_id"
    t.integer  "station_priority",    :default => 99
    t.string   "station_display",     :default => "true"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
