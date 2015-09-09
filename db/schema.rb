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

ActiveRecord::Schema.define(version: 20150909144121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string  "name",               default: "", null: false
    t.integer "publishments_count", default: 0,  null: false
  end

  add_index "authors", ["publishments_count"], name: "index_authors_on_publishments_count", using: :btree

  create_table "books", force: :cascade do |t|
    t.string  "name",         default: "",   null: false
    t.integer "published_at", default: 1940, null: false
  end

  create_table "books_authors", id: false, force: :cascade do |t|
    t.integer "author_id"
    t.integer "book_id"
  end

  add_index "books_authors", ["author_id"], name: "index_books_authors_on_author_id", using: :btree

  create_table "books_first_letters", id: false, force: :cascade do |t|
    t.string  "id",                null: false
    t.integer "count", default: 0, null: false
  end

  add_index "books_first_letters", ["id"], name: "index_books_first_letters_on_id", unique: true, using: :btree

  create_table "books_publishment_years", force: :cascade do |t|
    t.integer "count", default: 0, null: false
  end

end
