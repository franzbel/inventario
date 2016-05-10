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

ActiveRecord::Schema.define(version: 20160505033148) do

  create_table "incoming_amounts", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "product_id"
    t.integer  "incoming_movement_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.date     "expiration_date",      default: '3016-04-23'
  end

  add_index "incoming_amounts", ["incoming_movement_id"], name: "index_incoming_amounts_on_incoming_movement_id"
  add_index "incoming_amounts", ["product_id"], name: "index_incoming_amounts_on_product_id"

  create_table "incoming_movements", force: :cascade do |t|
    t.string   "movement_type"
    t.string   "supplier"
    t.string   "folio"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "outgoing_amounts", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "outgoing_movement_id"
    t.integer  "quantity"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.date     "expiration_date"
  end

  add_index "outgoing_amounts", ["outgoing_movement_id"], name: "index_outgoing_amounts_on_outgoing_movement_id"
  add_index "outgoing_amounts", ["product_id"], name: "index_outgoing_amounts_on_product_id"

  create_table "outgoing_movements", force: :cascade do |t|
    t.string   "movement_type"
    t.string   "receiver"
    t.string   "folio"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "part_number"
    t.string   "description"
    t.text     "specification"
    t.string   "unit"
    t.integer  "alert_before"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "maximum",            default: -1
    t.integer  "minimum",            default: -1
    t.integer  "optimum",            default: -1
    t.boolean  "expiration",         default: false
  end

  create_table "total_quantities", force: :cascade do |t|
    t.integer  "product_id"
    t.float    "quantity"
    t.date     "expiration_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "description"
  end

  add_index "total_quantities", ["product_id"], name: "index_total_quantities_on_product_id"

  create_table "units", force: :cascade do |t|
    t.string   "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
