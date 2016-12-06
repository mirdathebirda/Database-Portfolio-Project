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

ActiveRecord::Schema.define(version: 20161206193300) do

  create_table "blog", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "owner",                                    null: false
    t.string  "title",       limit: 52,                   null: false
    t.text    "description", limit: 65535,                null: false
    t.boolean "visible",                   default: true
    t.index ["owner"], name: "owner", using: :btree
    t.index ["title"], name: "title", using: :btree
  end

  create_table "category", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 52, null: false
    t.index ["name"], name: "name", unique: true, using: :btree
  end

  create_table "comment", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "author",                               null: false
    t.integer  "post",                                 null: false
    t.text     "text",    limit: 65535,                null: false
    t.datetime "date",                                 null: false
    t.boolean  "visible",               default: true
    t.index ["author"], name: "author", using: :btree
    t.index ["post"], name: "post", using: :btree
  end

  create_table "post", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "author",                                    null: false
    t.integer  "blog",                                      null: false
    t.string   "title",      limit: 52,                     null: false
    t.text     "body",       limit: 4294967295,             null: false
    t.datetime "date",                                      null: false
    t.integer  "star_count",                    default: 0, null: false
    t.index ["author"], name: "author", using: :btree
    t.index ["blog"], name: "blog", using: :btree
    t.index ["title"], name: "title", using: :btree
  end

  create_table "post_category", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "post"
    t.integer "category"
    t.index ["category"], name: "category", using: :btree
    t.index ["post", "category"], name: "post_category", unique: true, using: :btree
  end

  create_table "role", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 52
    t.index ["name"], name: "name", unique: true, using: :btree
  end

  create_table "star", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user",                   null: false
    t.integer "post",                   null: false
    t.boolean "starred", default: true
    t.index ["post"], name: "post", using: :btree
    t.index ["user", "post"], name: "user_star", unique: true, using: :btree
  end

  create_table "user", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name",            limit: 52,    null: false
    t.string "email",           limit: 52
    t.text   "password_digest", limit: 65535, null: false
    t.index ["email"], name: "email", unique: true, using: :btree
    t.index ["name"], name: "name", using: :btree
  end

  create_table "user_role", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user"
    t.integer "role"
    t.index ["role"], name: "role", using: :btree
    t.index ["user", "role"], name: "user_role", unique: true, using: :btree
  end

  add_foreign_key "blog", "user", column: "owner", name: "blog_ibfk_1"
  add_foreign_key "comment", "post", column: "post", name: "comment_ibfk_2"
  add_foreign_key "comment", "user", column: "author", name: "comment_ibfk_1"
  add_foreign_key "post", "blog", column: "blog", name: "post_ibfk_2"
  add_foreign_key "post", "user", column: "author", name: "post_ibfk_1"
  add_foreign_key "post_category", "category", column: "category", name: "post_category_ibfk_2"
  add_foreign_key "post_category", "post", column: "post", name: "post_category_ibfk_1"
  add_foreign_key "star", "post", column: "post", name: "star_ibfk_2"
  add_foreign_key "star", "user", column: "user", name: "star_ibfk_1"
  add_foreign_key "user_role", "role", column: "role", name: "user_role_ibfk_2"
  add_foreign_key "user_role", "user", column: "user", name: "user_role_ibfk_1"
end
