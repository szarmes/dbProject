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

ActiveRecord::Schema.define(version: 20130922003911) do

  create_table "cards", force: true do |t|
    t.integer "card_id", default: 0
    t.integer "deck_id", default: 0
    t.string  "qtext"
    t.string  "atext"
  end

  create_table "courses", force: true do |t|
    t.integer "subject_id",  null: false
    t.integer "course_id",   null: false
    t.string  "course_num",  null: false
    t.string  "name"
    t.integer "school_id"
    t.string  "school_name"
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
    t.string   "deck_title",                 null: false
    t.integer  "uses",           default: 0, null: false
    t.integer  "user_id",        default: 0, null: false
    t.string   "course_name"
    t.integer  "course_id"
    t.string   "course_num"
    t.string   "subject_name",               null: false
    t.integer  "subject_id",     default: 0, null: false
    t.string   "remember_token"
    t.datetime "created_on"
    t.integer  "school_id"
    t.string   "school_name"
    t.string   "prof_name"
    t.integer  "background",     default: 1
  end

  create_table "flagged_decks", force: true do |t|
    t.integer "deck_id", null: false
    t.string  "user_id", null: false
    t.string  "card_id", null: false
  end

  create_table "recent_decks", force: true do |t|
    t.integer  "user_id",   null: false
    t.integer  "deck_id",   null: false
    t.integer  "card_id",   null: false
    t.datetime "last_used"
  end

  create_table "results", force: true do |t|
    t.integer  "deck_id",     null: false
    t.string   "username",    null: false
    t.integer  "percent",     null: false
    t.datetime "created_on",  null: false
    t.string   "school_name"
    t.string   "prof_name"
  end

  create_table "saved_decks", force: true do |t|
    t.integer "user_id", null: false
    t.integer "deck_id", null: false
    t.integer "card_id", null: false
    t.integer "fav_id",  null: false
  end

  create_table "schools", force: true do |t|
    t.integer "school_id", null: false
    t.string  "name",      null: false
  end

  create_table "subjects", force: true do |t|
    t.integer "subject_id", null: false
    t.string  "name",       null: false
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.integer  "user_id",                default: 0,     null: false
    t.string   "email",                  default: "",    null: false
    t.integer  "decks_made",             default: 0,     null: false
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
    t.string   "school_name"
  end

end
