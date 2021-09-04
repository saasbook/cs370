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

ActiveRecord::Schema.define(version: 2021_09_03_210820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "password_digest"
    t.string "course_list", default: ["CS10", "CS61A", "CS61B", "CS61C", "CS70", "CS88", "EE16A", "EE16B", "DATA8", "UPPERDIV"], array: true
    t.text "tutor_types", default: "CSM (8-10 hours)\r\nTA (12 hours)\r\nAcademic Intern (36 hours)\r\nTutor (12 hours)"
    t.string "priority_list", array: true
    t.boolean "signups_allowed", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "meeting_id"
    t.boolean "took_place"
    t.string "course"
    t.decimal "hours"
    t.string "status", default: "Pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_id"
    t.index ["meeting_id"], name: "index_evaluations_on_meeting_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "tutor_id"
    t.bigint "request_id"
    t.datetime "set_time"
    t.string "set_location"
    t.boolean "is_scheduled", default: false
    t.boolean "is_done", default: false
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_meetings_on_request_id"
    t.index ["tutor_id"], name: "index_meetings_on_tutor_id"
  end

  create_table "question_templates", force: :cascade do |t|
    t.integer "order"
    t.string "prompt", default: "Your Prompt Here"
    t.boolean "is_optional", default: false
    t.string "question_type", default: "text"
    t.boolean "is_active", default: true
    t.boolean "is_admin_only", default: false
    t.json "details", default: {"min_char"=>50, "options"=>"Your Options Here", "min_val"=>1, "min_lab"=>"Poor", "max_val"=>7, "max_lab"=>"Great"}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "question_template_id"
    t.bigint "evaluation_id"
    t.string "prompt"
    t.text "response"
    t.boolean "is_admin_only"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evaluation_id"], name: "index_questions_on_evaluation_id"
    t.index ["question_template_id"], name: "index_questions_on_question_template_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "tutee_id"
    t.string "course"
    t.decimal "meeting_length"
    t.string "subject"
    t.string "status", default: "open"
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tutee_id"], name: "index_requests_on_tutee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "type", default: "Tutee"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.string "pronoun"
    t.string "ethnicity", array: true
    t.string "major"
    t.boolean "dsp"
    t.boolean "transfer"
    t.string "term"
    t.json "details"
    t.json "meta_values"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "evaluations", "meetings"
  add_foreign_key "meetings", "requests"
  add_foreign_key "meetings", "users", column: "tutor_id"
  add_foreign_key "questions", "evaluations"
  add_foreign_key "questions", "question_templates"
  add_foreign_key "requests", "users", column: "tutee_id"
end
