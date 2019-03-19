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

ActiveRecord::Schema.define(version: 2019_03_19_021036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classes", force: :cascade do |t|
    t.boolean "CS61A"
    t.boolean "CS61B"
    t.boolean "CS61C"
    t.boolean "CS70"
    t.boolean "EE16A"
    t.boolean "CS88"
    t.boolean "CS10"
    t.boolean "DATA8"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "tutor_id"
    t.bigint "request_id"
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_meetings_on_request_id"
    t.index ["tutor_id"], name: "index_meetings_on_tutor_id"
  end

  create_table "requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tutors", force: :cascade do |t|
    t.string "type_of_tutor"
    t.string "grade_level"
    t.integer "classes_id"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "meetings", "requests"
  add_foreign_key "meetings", "tutors"
end
