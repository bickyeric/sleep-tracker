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

ActiveRecord::Schema[8.0].define(version: 2025_10_02_172011) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id"], name: "index_follows_on_followee_id"
    t.index ["follower_id", "followee_id"], name: "index_follows_on_follower_id_and_followee_id", unique: true
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "sleep_summaries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.integer "total_sleep_duration_minutes"
    t.integer "total_sleep_sessions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "date"], name: "index_sleep_summaries_on_user_id_and_date", unique: true
  end

  create_table "sleeps", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "sleep_start", null: false
    t.datetime "sleep_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration_seconds"
    t.index ["user_id", "created_at", "duration_seconds"], name: "index_sleeps_on_user_id_and_created_at_and_duration_seconds"
    t.index ["user_id", "created_at", "id"], name: "index_sleeps_on_user_id_and_created_at_and_id"
    t.index ["user_id", "created_at"], name: "idx_sleeps_user_id_created_at"
    t.index ["user_id", "sleep_start"], name: "index_sleeps_on_user_id_and_sleep_start"
    t.index ["user_id"], name: "index_sleeps_on_user_id_where_sleep_end_null", where: "(sleep_end IS NULL)"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
