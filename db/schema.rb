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

ActiveRecord::Schema[7.0].define(version: 2023_08_20_214839) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "description"
    t.uuid "community_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_channels_on_community_id"
  end

  create_table "communities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "url"
    t.uuid "user_id", null: false
    t.string "primary_color"
    t.string "secondary_color"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_communities_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "community_id", null: false
    t.text "roles", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["community_id"], name: "index_memberships_on_community_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "phone"
    t.string "session_token"
    t.text "roles", default: [], array: true
    t.string "member_from", default: "#system"
    t.string "document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
  end

  add_foreign_key "channels", "communities"
  add_foreign_key "communities", "users"
  add_foreign_key "memberships", "communities"
  add_foreign_key "memberships", "users"
end
