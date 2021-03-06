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

ActiveRecord::Schema.define(version: 20180405074928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "amount"
    t.string "reference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "queue_items", force: :cascade do |t|
    t.integer "position"
    t.integer "user_id"
    t.integer "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "video_id"], name: "index_queue_items_on_user_id_and_video_id", unique: true
    t.index ["user_id"], name: "index_queue_items_on_user_id"
  end

  create_table "reset_passwords", force: :cascade do |t|
    t.string "token"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_reset_passwords_on_email", unique: true
    t.index ["token", "email"], name: "index_reset_passwords_on_token_and_email"
    t.index ["token"], name: "index_reset_passwords_on_token"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "video_id"
    t.bigint "user_id"
    t.integer "rating"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "video_id"], name: "index_reviews_on_user_id_and_video_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["video_id"], name: "index_reviews_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", limit: 72
    t.boolean "is_admin"
    t.boolean "paid"
    t.string "reference_id"
    t.integer "amount"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["paid"], name: "index_users_on_paid"
  end

  create_table "videos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.integer "category_id"
    t.string "large_cover"
    t.string "small_cover"
    t.string "trailer_url"
    t.index ["category_id"], name: "index_videos_on_category_id"
  end

end
