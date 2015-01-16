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

ActiveRecord::Schema.define(version: 20150116125235) do

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "twitter"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "contact"
    t.text     "activities"
    t.string   "email"
    t.string   "level"
    t.string   "founded_on"
    t.boolean  "full",       default: false
  end

  create_table "memberships", force: true do |t|
    t.integer  "group_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "memberships", ["group_id", "person_id"], name: "index_memberships_on_group_id_and_person_id", unique: true
  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id"
  add_index "memberships", ["person_id"], name: "index_memberships_on_person_id"

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "picture"
    t.string   "twitter"
    t.text     "working_on"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true
  add_index "people", ["group_id"], name: "index_people_on_group_id"
  add_index "people", ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true

  create_table "people_roles", id: false, force: true do |t|
    t.integer "person_id"
    t.integer "role_id"
  end

  add_index "people_roles", ["person_id", "role_id"], name: "index_people_roles_on_person_id_and_role_id"

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.boolean  "draft",       default: false, null: false
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "topics", force: true do |t|
    t.text     "body"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.datetime "covered_at"
  end

end
