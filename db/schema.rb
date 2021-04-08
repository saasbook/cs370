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

ActiveRecord::Schema.define(version: 2021_03_19_022628) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "password_digest"
    t.string "statistics_semester"
    t.string "current_semester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "berkeley_classes", force: :cascade do |t|
    t.boolean "CS61A"
    t.boolean "CS61B"
    t.boolean "CS61C"
    t.boolean "CS70"
    t.boolean "EE16A"
    t.boolean "CS88"
    t.boolean "CS10"
    t.boolean "DATA8"
    t.boolean "EE16B", default: false
    t.boolean "UPPERDIV", default: false
    t.boolean "OTHER", default: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "course_num"
    t.string "name"
    t.string "semester"
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "evaluations", force: :cascade do |t|
    t.boolean "took_place"
    t.string "topics"
    t.float "hours"
    t.text "positive"
    t.text "best"
    t.text "feedback"
    t.integer "knowledgeable", limit: 2
    t.integer "helpful", limit: 2
    t.integer "clarity", limit: 2
    t.integer "pacing", limit: 2
    t.text "final_comments"
    t.string "status", default: "Pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "evaluation_id"
    t.bigint "request_id"
    t.bigint "tutee_id"
    t.bigint "tutor_id"
    t.boolean "is_done", default: false
    t.boolean "is_scheduled", default: false
    t.datetime "created_at", null: false
    t.datetime "set_time"
    t.datetime "times", default: [], array: true
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_meetings_on_evaluation_id"
    t.index ["request_id"], name: "index_meetings_on_request_id"
    t.index ["tutee_id"], name: "index_meetings_on_tutee_id"
    t.index ["tutor_id"], name: "index_meetings_on_tutor_id"
    t.json "meta_values"
    t.string "locations", default: [], array: true
    t.string "set_location"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "tutee_id"
    t.bigint "course_id"
    t.integer "meeting_length", limit: 2
    t.string "subject"
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_requests_on_course_id"
    t.index ["tutee_id"], name: "index_requests_on_tutee_id"
  end

  create_table "tutees", force: :cascade do |t|
    t.bigint "sid"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "email", default: "", null: false
    t.string "privilege", default: "No"
    t.string "gender", default: "prefer not to say"
    t.string "pronoun", default: "other"
    t.string "ethnicity", default: "prefer not to say"
    t.string "major", default: "CS"
    t.string "dsp", default: "No"
    t.string "transfer", default: "No"
    t.string "year", default: "1 year"
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_tutees_on_confirmation_token", unique: true
    t.index ["email"], name: "index_tutees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_tutees_on_reset_password_token", unique: true
  end

  create_table "tutors", force: :cascade do |t|
    t.string "type_of_tutor"
    t.string "grade_level"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "berkeley_classes_id"
    t.date "birthday"
    t.string "gender"
    t.bigint "sid"
    t.string "major"
    t.boolean "dsp?"
    t.boolean "transfer?"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["berkeley_classes_id"], name: "index_tutors_on_berkeley_classes_id"
    t.index ["confirmation_token"], name: "index_tutors_on_confirmation_token", unique: true
    t.index ["email"], name: "index_tutors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_tutors_on_reset_password_token", unique: true
  end

  add_foreign_key "meetings", "evaluations"
  add_foreign_key "meetings", "requests"
  add_foreign_key "meetings", "tutees"
  add_foreign_key "meetings", "tutors"
  add_foreign_key "requests", "courses"
  add_foreign_key "requests", "tutees"
  add_foreign_key "tutors", "berkeley_classes", column: "berkeley_classes_id"
end
