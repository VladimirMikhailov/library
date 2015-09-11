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

ActiveRecord::Schema.define(version: 20150913010109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string  "name",               default: "", null: false
    t.integer "publishments_count", default: 0,  null: false
  end

  add_index "authors", ["publishments_count"], name: "index_authors_on_publishments_count", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "name",         default: "",   null: false
    t.integer  "published_at", default: 1940, null: false
    t.datetime "deleted_at"
  end

  create_table "books_authors", id: false, force: :cascade do |t|
    t.integer "author_id"
    t.integer "book_id"
  end

  add_index "books_authors", ["author_id"], name: "index_books_authors_on_author_id", using: :btree
  add_index "books_authors", ["book_id"], name: "index_books_authors_on_book_id", using: :btree

  create_table "books_first_letters", id: false, force: :cascade do |t|
    t.string  "id",                null: false
    t.integer "count", default: 0, null: false
  end

  add_index "books_first_letters", ["id"], name: "index_books_first_letters_on_id", unique: true, using: :btree

  create_table "books_publishment_years", force: :cascade do |t|
    t.integer "count", default: 0, null: false
  end

  create_table "que_jobs", id: false, force: :cascade do |t|
    t.integer  "priority",    limit: 2, default: 100,                   null: false
    t.datetime "run_at",                default: '2015-09-10 23:30:00', null: false
    t.integer  "job_id",      limit: 8, default: 0,                     null: false
    t.text     "job_class",                                             null: false
    t.json     "args",                  default: [],                    null: false
    t.integer  "error_count",           default: 0,                     null: false
    t.text     "last_error"
    t.text     "queue",                 default: "",                    null: false
  end

end
