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

ActiveRecord::Schema.define(version: 20170115011515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_stats", force: :cascade do |t|
    t.date     "stat_date",                  null: false
    t.decimal  "calories",   default: "0.0"
    t.decimal  "fat",        default: "0.0"
    t.decimal  "carbs",      default: "0.0"
    t.decimal  "protein",    default: "0.0"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_daily_stats_on_user_id", using: :btree
  end

  create_table "entries", force: :cascade do |t|
    t.date     "entry_date",                   null: false
    t.decimal  "servings",     default: "1.0"
    t.string   "serving_size",                 null: false
    t.string   "serving_type",                 null: false
    t.decimal  "calories",     default: "0.0"
    t.decimal  "fat",          default: "0.0"
    t.decimal  "carbs",        default: "0.0"
    t.decimal  "protein",      default: "0.0"
    t.integer  "user_id"
    t.integer  "food_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["food_id"], name: "index_entries_on_food_id", using: :btree
    t.index ["user_id"], name: "index_entries_on_user_id", using: :btree
  end

  create_table "foods", force: :cascade do |t|
    t.text     "brand",                        null: false
    t.text     "name",                         null: false
    t.decimal  "serving_size",                 null: false
    t.string   "serving_type",                 null: false
    t.decimal  "calories",     default: "0.0"
    t.decimal  "fat",          default: "0.0"
    t.decimal  "carbs",        default: "0.0"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                null: false
    t.string   "password_digest",      null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_foreign_key "daily_stats", "users"
  add_foreign_key "entries", "foods"
  add_foreign_key "entries", "users"
end
