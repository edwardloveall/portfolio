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

ActiveRecord::Schema[7.0].define(version: 2022_03_24_181744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "authorizations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "client_id", null: false
    t.string "scope"
    t.string "code"
    t.datetime "code_expires_at", precision: nil
    t.string "token"
    t.datetime "token_expires_at", precision: nil
    t.integer "user_id"
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "internal_posts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "title"
    t.text "body"
    t.string "slug"
    t.string "tumblr_guid"
  end

  create_table "posts", force: :cascade do |t|
    t.string "postable_type", default: "InternalPost"
    t.bigint "postable_id"
    t.index ["postable_type", "postable_id"], name: "index_posts_on_postable"
  end

  create_table "projects", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "title"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at", precision: nil
    t.string "role"
    t.string "website"
    t.text "description"
    t.datetime "featured_at", precision: nil
    t.string "slug"
    t.integer "position"
    t.datetime "published_at", precision: nil
    t.index ["slug"], name: "index_projects_on_slug", unique: true
    t.index ["title"], name: "index_projects_on_title", unique: true
  end

  create_table "songs", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "title"
    t.text "description"
    t.string "mp3_file_name"
    t.string "mp3_content_type"
    t.integer "mp3_file_size"
    t.datetime "mp3_updated_at", precision: nil
    t.integer "position"
    t.string "ogg_file_name"
    t.string "ogg_content_type"
    t.integer "ogg_file_size"
    t.datetime "ogg_updated_at", precision: nil
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.text "me"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
