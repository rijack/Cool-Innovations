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

ActiveRecord::Schema.define(:version => 20120713021125) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.text     "payment_instructions"
    t.text     "shipping_instructions"
    t.text     "special_instructions"
  end

  create_table "hardwares", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "comment"
    t.text     "vendor_name"
    t.text     "pricing_i"
    t.text     "pricing_history"
  end

  create_table "order_line_process_statuses", :force => true do |t|
    t.integer  "order_line_id"
    t.integer  "part_process_id"
    t.string   "status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
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
    t.text     "production_comment"
    t.decimal  "price",              :precision => 8, :scale => 2
    t.integer  "shipping_method_id"
    t.date     "actual_ship_date"
    t.integer  "line_number"
    t.string   "tracking_number"
    t.string   "color",                                            :default => "white"
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

  create_table "part_processes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "shipping_methods", :force => true do |t|
    t.string   "name"
    t.string   "duration"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "type"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "status",          :default => "user"
  end

end
