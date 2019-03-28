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

  create_table "diaries", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "comment"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "goal_id"
    t.index ["goal_id"], name: "index_diaries_on_goal_id"
  end

  create_table "goals", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.integer "category_num"
    t.timestamp "start_date"
    t.timestamp "end_date"
    t.boolean "is_doing"
    t.decimal "average_score", precision: 10
    t.string "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_nickname"
    t.bigint "partner_nickname"
    t.index ["partner_nickname"], name: "index_goals_on_partner_nickname"
    t.index ["user_nickname"], name: "index_goals_on_user_nickname"
  end

  create_table "users", primary_key: "nickname", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "password"
    t.string "image_path"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
