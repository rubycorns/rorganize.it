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

ActiveRecord::Schema.define(version: 20180130234037) do

  create_table "comments", force: :cascade do |t|
    t.string   "person_id",  null: false
    t.text     "body",       null: false
    t.integer  "topic_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "groups", force: :cascade do |t|
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
    t.boolean  "full",                default: false
    t.string   "city"
    t.string   "country"
    t.string   "zip"
    t.string   "street"
    t.string   "slug"
    t.text     "learning_resources"
    t.boolean  "inactive",            default: false
    t.boolean  "allow_male_students", default: false
    t.boolean  "searching_coaches",   default: false, null: false
    t.boolean  "searching_students",  default: false, null: false
    t.boolean  "searching_location",  default: false, null: false
    t.index ["slug"], name: "index_groups_on_slug", unique: true
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.boolean  "admin",      default: false, null: false
    t.index ["group_id", "person_id"], name: "index_memberships_on_group_id_and_person_id", unique: true
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["person_id"], name: "index_memberships_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "",    null: false
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "picture"
    t.string   "twitter"
    t.text     "working_on"
    t.boolean  "workshop_coach"
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "willing_to_travel",      default: false
    t.string   "city"
    t.string   "country"
    t.string   "website"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "non_public",             default: false, null: false
    t.boolean  "searching_group",        default: false, null: false
    t.string   "github_handle"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["group_id"], name: "index_people_on_group_id"
    t.index ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.boolean  "draft",        default: false, null: false
    t.string   "slug"
    t.datetime "published_at"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.text     "body"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.datetime "covered_at"
  end

end
