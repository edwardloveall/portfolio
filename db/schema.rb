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

ActiveRecord::Schema.define(version: 20180522011807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "client_id",        null: false
    t.string   "scope"
    t.string   "code"
    t.datetime "code_expires_at"
    t.string   "token"
    t.datetime "token_expires_at"
  end

  create_table "microposts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "body"
    t.string   "ms_epoch"
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.string   "tumblr_guid"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "title"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "role"
    t.string   "website"
    t.text     "description"
    t.datetime "featured_at"
    t.string   "slug"
    t.integer  "position"
    t.datetime "published_at"
    t.index ["slug"], name: "index_projects_on_slug", unique: true, using: :btree
    t.index ["title"], name: "index_projects_on_title", unique: true, using: :btree
  end

  create_table "songs", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "title"
    t.text     "description"
    t.string   "mp3_file_name"
    t.string   "mp3_content_type"
    t.integer  "mp3_file_size"
    t.datetime "mp3_updated_at"
    t.integer  "position"
    t.string   "ogg_file_name"
    t.string   "ogg_content_type"
    t.integer  "ogg_file_size"
    t.datetime "ogg_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
