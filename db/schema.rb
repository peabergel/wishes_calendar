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

ActiveRecord::Schema[7.0].define(version: 2022_06_12_134200) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_calendars_on_user_id"
  end

  create_table "event_movies", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_movies_on_event_id"
    t.index ["movie_id"], name: "index_event_movies_on_movie_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "calendar_id", null: false
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_events_on_calendar_id"
  end

  create_table "genre_movies", force: :cascade do |t|
    t.bigint "genre_id", null: false
    t.bigint "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_genre_movies_on_genre_id"
    t.index ["movie_id"], name: "index_genre_movies_on_movie_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "director"
    t.string "poster_path"
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "synopsis"
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

  add_foreign_key "calendars", "users"
  add_foreign_key "event_movies", "events"
  add_foreign_key "event_movies", "movies"
  add_foreign_key "events", "calendars"
  add_foreign_key "genre_movies", "genres"
  add_foreign_key "genre_movies", "movies"
end
