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

ActiveRecord::Schema.define(version: 20170203143648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.date     "check_in"
    t.date     "check_out"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.string   "street_name"
    t.string   "street_number"
    t.string   "city"
    t.string   "zip_code"
    t.integer  "people"
    t.decimal  "total_price",   precision: 7, scale: 2
    t.boolean  "confirmed",                             default: false
    t.boolean  "paid",                                  default: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  create_table "carousels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "page_id"
    t.index ["page_id"], name: "index_carousels_on_page_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.boolean  "hidden"
  end

  create_table "paragraphs", force: :cascade do |t|
    t.text     "text"
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "heading"
    t.index ["page_id"], name: "index_paragraphs_on_page_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "image"
    t.string   "photo_page_type"
    t.integer  "photo_page_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "prices", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "min_days"
    t.decimal  "weekly_price",   precision: 7, scale: 2
    t.decimal  "extra_price",    precision: 7, scale: 2
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.boolean  "saturdays_only",                         default: false
    t.decimal  "service_costs",  precision: 7, scale: 2
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "name"
    t.integer  "stars"
    t.text     "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "carousels", "pages"
  add_foreign_key "paragraphs", "pages"
end
