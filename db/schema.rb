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

ActiveRecord::Schema.define(version: 20180105053849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "text"
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "text", null: false
    t.integer "commentable_id", null: false
    t.string "commentable_type", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text", null: false
    t.bigint "user_id", null: false
    t.integer "dup_id"
    t.boolean "wiki", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "revisions", force: :cascade do |t|
    t.jsonb "metadata"
    t.integer "revisable_id", null: false
    t.string "revisable_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["revisable_id"], name: "index_revisions_on_revisable_id"
    t.index ["revisable_type"], name: "index_revisions_on_revisable_type"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "auth_token", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_token"], name: "index_sessions_on_auth_token"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tag_associations", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "tagable_id", null: false
    t.string "tagable_type", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tagable_id"], name: "index_tag_associations_on_tagable_id"
    t.index ["tagable_type"], name: "index_tag_associations_on_tagable_type"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "enc_password", null: false
    t.string "salt", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["salt"], name: "index_users_on_salt"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "votable_id", null: false
    t.string "votable_type", null: false
    t.integer "user_id", null: false
    t.boolean "is_active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["votable_id", "votable_type"], name: "index_votes_on_votable_id_and_votable_type"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "sessions", "users"
end
