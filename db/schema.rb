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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130402103017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: true do |t|
    t.integer  "board_id",   null: false
    t.string   "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["board_id"], name: "index_bids_on_board_id"

  create_table "boards", force: true do |t|
    t.string   "deal_id",    null: false
    t.string   "dealer",     null: false
    t.string   "vulnerable", null: false
    t.string   "contract"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: true do |t|
    t.integer  "board_id",   null: false
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["board_id", "content"], name: "index_cards_on_board_id_and_content", unique: true
  add_index "cards", ["board_id"], name: "index_cards_on_board_id"

  create_table "channels", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "connected_at"
    t.datetime "disconnected_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "channels", ["name"], name: "index_channels_on_name", unique: true

  create_table "tables", force: true do |t|
    t.integer  "user_n_id"
    t.integer  "user_e_id"
    t.integer  "user_s_id"
    t.integer  "user_w_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
