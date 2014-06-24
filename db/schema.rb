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

ActiveRecord::Schema.define(version: 20140624194055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: true do |t|
    t.integer  "source_document_id"
    t.integer  "annotation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "source_text"
  end

  add_index "annotations", ["annotation_id"], name: "index_annotations_on_annotation_id", using: :btree
  add_index "annotations", ["source_document_id"], name: "index_annotations_on_source_document_id", using: :btree

  create_table "documents", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["title"], name: "index_documents_on_title", unique: true, using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "friendships", force: true do |t|
    t.integer  "friender_id"
    t.integer  "befriended_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["befriended_id"], name: "index_friendships_on_befriended_id", using: :btree
  add_index "friendships", ["friender_id"], name: "index_friendships_on_friender_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
