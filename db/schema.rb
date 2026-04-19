# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_18_193121) do
  create_table "hotels", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "country"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.date "check_in"
    t.date "check_out"
    t.datetime "created_at", null: false
    t.integer "guests_count"
    t.integer "room_id", null: false
    t.integer "status"
    t.decimal "total_price"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["room_id"], name: "index_reservations_on_room_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "room_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "hotel_id", null: false
    t.string "number"
    t.decimal "price"
    t.integer "room_type_id", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_rooms_on_hotel_id"
    t.index ["room_type_id"], name: "index_rooms_on_room_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "identification"
    t.string "name"
    t.string "password_digest"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "reservations", "rooms"
  add_foreign_key "reservations", "users"
  add_foreign_key "rooms", "hotels"
  add_foreign_key "rooms", "room_types"
end
