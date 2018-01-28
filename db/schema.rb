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

ActiveRecord::Schema.define(version: 20180128215926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "team_players", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id"
    t.string "name", limit: 30
    t.string "battletag", limit: 30
    t.string "role", limit: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_players_on_team_id"
    t.index ["user_id"], name: "index_team_players_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.integer "average_sr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "battletag", limit: 30, null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "platform", limit: 3
    t.string "region", limit: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_token", limit: 20
    t.index ["api_token", "battletag"], name: "index_users_on_api_token_and_battletag", unique: true
    t.index ["battletag"], name: "index_users_on_battletag", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

end
