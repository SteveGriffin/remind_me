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

ActiveRecord::Schema.define(version: 20150210010402) do

  create_table "reminders", force: true do |t|
    t.string   "message"
    t.datetime "reminder_time"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",        default: true
    t.integer  "user_id"
    t.boolean  "call",          default: false
    t.boolean  "sms",           default: false
  end

  add_index "reminders", ["user_id"], name: "index_reminders_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",          default: true
    t.boolean  "admin",           default: false
    t.string   "phone"
    t.string   "password_digest"
  end

end
