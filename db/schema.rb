# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_14_084819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "post_code"
    t.string "city"
    t.string "segment"
    t.string "AMAP_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_line_product_lots", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "product_lot_id", null: false
    t.bigint "order_line_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_line_id"], name: "index_order_line_product_lots_on_order_line_id"
    t.index ["product_lot_id"], name: "index_order_line_product_lots_on_product_lot_id"
  end

  create_table "order_lines", force: :cascade do |t|
    t.integer "quantity"
    t.integer "total_price_cents"
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_lines_on_order_id"
    t.index ["product_id"], name: "index_order_lines_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "date"
    t.integer "total_price_cents"
    t.string "status"
    t.string "payment_method"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
  end

  create_table "product_lots", force: :cascade do |t|
    t.date "production_date"
    t.date "expiry_date"
    t.integer "quantity"
    t.integer "remaining_quantity"
    t.string "lot_number"
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_lots_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "unit_price_cents"
    t.string "unit_type"
    t.string "product_fruit"
    t.string "product_type"
    t.string "product_category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "order_line_product_lots", "order_lines"
  add_foreign_key "order_line_product_lots", "product_lots"
  add_foreign_key "order_lines", "orders"
  add_foreign_key "order_lines", "products"
  add_foreign_key "orders", "clients"
  add_foreign_key "product_lots", "products"
end
