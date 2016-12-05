class CreateDatabase < ActiveRecord::Migration
    def self.up
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

      ActiveRecord::Schema.define(version: 0) do

        create_table "role", primary_key: "roleID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
          t.string "name", limit: 52
          t.index ["roleID"], name: "roleID", unique: true, using: :btree
        end

        create_table "category", primary_key: "type", id: :string, limit: 52, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
        end

        create_table "user", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
          t.string  "name", limit: 52
          t.integer "role"
          t.index ["name"], name: "name", unique: true, using: :btree
          t.index ["role"], name: "role", using: :btree
        end
        add_foreign_key "user", "role", column: "role", primary_key: "roleID", name: "user_ibfk_1"

        create_table "blog", primary_key: "blogID", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
          t.string "admin", limit: 52
          t.index ["admin"], name: "admin", using: :btree
          t.index ["blogID"], name: "blogID", unique: true, using: :btree
        end
        add_foreign_key "blog", "user", column: "admin", primary_key: "name", name: "blog_ibfk_1"

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

        add_foreign_key "post", "blog", column: "blogID", primary_key: "blogID", name: "post_ibfk_2"
        add_foreign_key "post", "category", column: "tag", primary_key: "type", name: "post_ibfk_1"

        create_table "comment", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
          t.string  "comment", limit: 100
          t.integer "post"
          t.string  "user",    limit: 52
          t.index ["post"], name: "post", using: :btree
          t.index ["user"], name: "user", unique: true, using: :btree
        end

        add_foreign_key "comment", "post", column: "post", primary_key: "postID", name: "comment_ibfk_1"
        add_foreign_key "comment", "user", column: "user", primary_key: "name", name: "comment_ibfk_2"

        create_table "likes", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
          t.string  "User", limit: 52
          t.integer "post"
          t.index ["User"], name: "User", using: :btree
          t.index ["post"], name: "post", using: :btree
        end

        add_foreign_key "likes", "post", column: "post", primary_key: "postID", name: "likes_ibfk_1"
        add_foreign_key "likes", "user", column: "User", primary_key: "name", name: "likes_ibfk_2"

        create_table "post_category", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
          t.integer "postID"
          t.integer  "category", limit: 52
          t.index ["category"], name: "category", using: :btree
          t.index ["postID"], name: "postID", unique: true, using: :btree
        end

        add_foreign_key "postcategories", "category", column: "category", primary_key: "type", name: "postcategories_ibfk_2"
        add_foreign_key "postcategories", "post", column: "postID", primary_key: "postID", name: "postcategories_ibfk_1"

      end

    end

    def self.down
      # drop all the tables if you really need
      # to support migration back to version 0
      drop_table :postcategories
      drop_table :likes
      drop_table :comment
      drop_table :post
      drop_table :blog
      drop_table :user
      drop_table :category
      drop_table :role

    end
end
