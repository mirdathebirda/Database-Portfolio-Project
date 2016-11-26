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

ActiveRecord::Schema.define(version: 20161126041958) do

  create_table "blog", primary_key: "blogID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "admin", limit: 52
    t.index ["admin"], name: "admin", using: :btree
    t.index ["blogID"], name: "blogID", unique: true, using: :btree
  end

  create_table "category", primary_key: "type", id: :string, limit: 52, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
  end

  create_table "comment", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "comment", limit: 100
    t.integer "post"
    t.string  "user",    limit: 52
    t.index ["post"], name: "post", using: :btree
    t.index ["user"], name: "user", unique: true, using: :btree
  end

  create_table "likes", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "User", limit: 52
    t.integer "post"
    t.index ["User"], name: "User", using: :btree
    t.index ["post"], name: "post", using: :btree
  end

  create_table "post", primary_key: "postID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user",    limit: 52,                  null: false
    t.string   "tag",     limit: 52
    t.string   "title",   limit: 52
    t.datetime "date"
    t.string   "comment", limit: 100
    t.boolean  "isLiked",             default: false
    t.integer  "blogID"
    t.index ["blogID"], name: "blogID", unique: true, using: :btree
    t.index ["postID"], name: "postID", unique: true, using: :btree
    t.index ["tag"], name: "tag", using: :btree
  end

  create_table "postcategories", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "postID"
    t.string  "category", limit: 52
    t.index ["category"], name: "category", using: :btree
    t.index ["postID"], name: "postID", unique: true, using: :btree
  end

  create_table "role", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 52
    t.index ["name"], name: "name", unique: true, using: :btree
  end

  create_table "user", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",            limit: 52
    t.string  "password_digest", limit: 100
    t.string  "email",           limit: 52
    t.integer "role"
    t.index ["email"], name: "email", unique: true, using: :btree
    t.index ["name"], name: "name", unique: true, using: :btree
    t.index ["role"], name: "role", using: :btree
  end

  add_foreign_key "blog", "user", column: "admin", primary_key: "name", name: "blog_ibfk_1"
  add_foreign_key "comment", "post", column: "post", primary_key: "postID", name: "comment_ibfk_1"
  add_foreign_key "comment", "user", column: "user", primary_key: "name", name: "comment_ibfk_2"
  add_foreign_key "likes", "post", column: "post", primary_key: "postID", name: "likes_ibfk_1"
  add_foreign_key "likes", "user", column: "User", primary_key: "name", name: "likes_ibfk_2"
  add_foreign_key "post", "blog", column: "blogID", primary_key: "blogID", name: "post_ibfk_2"
  add_foreign_key "post", "category", column: "tag", primary_key: "type", name: "post_ibfk_1"
  add_foreign_key "postcategories", "category", column: "category", primary_key: "type", name: "postcategories_ibfk_2"
  add_foreign_key "postcategories", "post", column: "postID", primary_key: "postID", name: "postcategories_ibfk_1"
  add_foreign_key "user", "role", column: "role", name: "user_ibfk_1"
end
