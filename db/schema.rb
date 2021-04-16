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

ActiveRecord::Schema.define(version: 2021_04_14_140728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessment_responses", force: :cascade do |t|
    t.boolean "is_correct"
    t.string "response"
    t.integer "display_order"
    t.boolean "visible"
    t.bigint "assessment_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["assessment_id"], name: "index_assessment_responses_on_assessment_id"
    t.index ["question_id"], name: "index_assessment_responses_on_question_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.integer "score"
    t.integer "total_question"
    t.bigint "user_id", null: false
    t.bigint "test_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_id"], name: "index_assessments_on_test_id"
    t.index ["user_id"], name: "index_assessments_on_user_id"
  end

  create_table "question_answers", force: :cascade do |t|
    t.integer "index"
    t.string "content"
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_correct"
    t.index ["question_id"], name: "index_question_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "correct_answer"
    t.boolean "mark_for_delete"
    t.bigint "test_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_id"], name: "index_questions_on_test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "mark_for_delete"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "assessment_responses", "assessments"
  add_foreign_key "assessment_responses", "questions"
  add_foreign_key "assessments", "tests"
  add_foreign_key "assessments", "users"
  add_foreign_key "question_answers", "questions"
  add_foreign_key "questions", "tests"
end
