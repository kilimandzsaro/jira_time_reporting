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

ActiveRecord::Schema.define(version: 20170518183541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string   "jira_name"
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "componenets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "issue_history_id"
    t.index ["issue_history_id"], name: "index_employees_on_issue_history_id", using: :btree
  end

  create_table "issue_histories", force: :cascade do |t|
    t.integer  "issue_id"
    t.string   "status"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "employee_id"
    t.integer  "component_id"
    t.integer  "business_id"
    t.time     "duration"
    t.integer  "project_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "jira_id"
    t.string   "issue_key"
    t.string   "title"
    t.boolean  "is_done"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "issue_history_id"
    t.index ["issue_history_id"], name: "index_issues_on_issue_history_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "prefix"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
