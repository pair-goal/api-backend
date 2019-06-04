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

ActiveRecord::Schema.define(version: 2019_03_23_052213) do

  create_table "diaries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "comment"
    t.integer "score"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "goal_id"
    t.bigint "pre_id"
    t.bigint "next_id"
    t.index ["goal_id"], name: "index_diaries_on_goal_id"
    t.index ["next_id"], name: "index_diaries_on_next_id"
    t.index ["pre_id"], name: "index_diaries_on_pre_id"
  end

  create_table "goals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.integer "category_num"
    t.timestamp "start_date"
    t.timestamp "end_date"
    t.boolean "is_doing", default: true
    t.decimal "average_score", precision: 10, default: "0"
    t.integer "zero_score", default: 0
    t.integer "one_score", default: 0
    t.integer "two_score", default: 0
    t.integer "three_score", default: 0
    t.integer "four_score", default: 0
    t.integer "five_score", default: 0
    t.string "image_path"
    t.string "partner_name"
    t.string "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "partner_id"
    t.bigint "last_diary_id"
    t.index ["last_diary_id"], name: "index_goals_on_last_diary_id"
    t.index ["partner_id"], name: "index_goals_on_partner_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname"
    t.string "password_digest"
    t.string "image_path"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
