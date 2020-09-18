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

ActiveRecord::Schema.define(version: 2020_07_30_230707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.string "tags", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tags"], name: "index_bookmarks_on_tags", using: :gin
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "feeds", force: :cascade do |t|
    t.string "url"
    t.string "format"
    t.string "title"
    t.string "summary"
    t.string "generator"
    t.datetime "updated"
    t.datetime "published"
    t.text "authors"
    t.text "tags"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["url"], name: "index_feeds_on_url", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "guid"
    t.string "external_url"
    t.string "title"
    t.string "summary"
    t.datetime "updated"
    t.datetime "published"
    t.text "content_html"
    t.text "content_text"
    t.text "authors"
    t.text "tags"
    t.text "attachments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guid"], name: "index_items_on_guid", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "url"
    t.string "name"
    t.boolean "private"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["url"], name: "index_profiles_on_url", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "item_id", null: false
    t.string "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_reactions_on_item_id"
    t.index ["profile_id"], name: "index_reactions_on_profile_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.bigint "feed_id", null: false
    t.boolean "notify"
    t.boolean "mute"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feed_id"], name: "index_subscriptions_on_feed_id"
    t.index ["profile_id", "feed_id"], name: "index_subscriptions_on_profile_id_and_feed_id", unique: true
    t.index ["profile_id"], name: "index_subscriptions_on_profile_id"
  end

  create_table "syndications", force: :cascade do |t|
    t.bigint "feed_id", null: false
    t.bigint "item_id", null: false
    t.boolean "shared"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feed_id", "item_id"], name: "index_syndications_on_feed_id_and_item_id", unique: true
    t.index ["feed_id"], name: "index_syndications_on_feed_id"
    t.index ["item_id"], name: "index_syndications_on_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "bookmarks", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "reactions", "items"
  add_foreign_key "reactions", "profiles"
  add_foreign_key "subscriptions", "feeds"
  add_foreign_key "subscriptions", "profiles"
  add_foreign_key "syndications", "feeds"
  add_foreign_key "syndications", "items"
end
