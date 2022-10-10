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

ActiveRecord::Schema[7.0].define(version: 2022_10_10_085523) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_bookings_on_event_id"
    t.index ["user_id"], name: "index_event_bookings_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "location"
    t.date "date"
    t.time "time"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.boolean "verified_user", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "shop_admins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_shop_admins_on_shop_id"
    t.index ["user_id"], name: "index_shop_admins_on_user_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "summary"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.string "shop_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "event_bookings", "events"
  add_foreign_key "event_bookings", "users"
  add_foreign_key "events", "users"
  add_foreign_key "roles", "users"
  add_foreign_key "shop_admins", "shops"
  add_foreign_key "shop_admins", "users"
end
