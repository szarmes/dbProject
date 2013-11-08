# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131008164900) do

  create_table "cards", force: true do |t|
    t.integer "card_id", default: 0, null: false
    t.integer "deck_id", default: 0, null: false
    t.string  "qtext",               null: false
    t.string  "atext",               null: false
  end

  create_table "courses", force: true do |t|
    t.integer "subject_id", null: false
    t.integer "course_id",  null: false
    t.string  "courseNum",  null: false
    t.string  "name"
  end

  create_table "deckratings", force: true do |t|
    t.integer  "deckrating_id",                 null: false
    t.integer  "deck_id",                       null: false
    t.integer  "user_id",                       null: false
    t.boolean  "liked",         default: false
    t.datetime "created_at"
  end

  create_table "decks", force: true do |t|
    t.integer  "deck_id",        default: 0, null: false
    t.string   "deckTitle",                  null: false
    t.integer  "uses",           default: 0, null: false
    t.integer  "user_id",        default: 0, null: false
    t.string   "courseName"
    t.integer  "course_id"
    t.string   "courseNum"
    t.string   "subjectname",                null: false
    t.integer  "subject_id",     default: 0, null: false
    t.string   "remember_token"
    t.datetime "created_on"
  end

  create_table "recent_decks", force: true do |t|
    t.integer  "user_id",  null: false
    t.integer  "deck_id",  null: false
    t.integer  "card_id",  null: false
    t.datetime "lastUsed"
  end

  create_table "results", force: true do |t|
    t.integer  "deck_id",    null: false
    t.string  "username",    null: false
    t.integer  "percent",    null: false
    t.datetime "created_on", null: false
  end

  create_table "saved_decks", force: true do |t|
    t.integer "user_id", null: false
    t.integer "deck_id", null: false
    t.integer "card_id", null: false
    t.integer "fav_id",  null: false
  end

  create_table "subjects", force: true do |t|
    t.integer "subject_id", null: false
    t.string  "name",       null: false
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.integer  "user_id",                default: 0,     null: false
    t.string   "email",                  default: "",    null: false
    t.integer  "decksMade",              default: 0,     null: false
    t.boolean  "paid",                   default: false
    t.boolean  "admin",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
