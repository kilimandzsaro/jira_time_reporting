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

ActiveRecord::Schema.define(version: 20170602114245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string   "jira_name"
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "businesses_issues", force: :cascade do |t|
    t.integer "business_id"
    t.integer "issue_id"
    t.index ["business_id"], name: "index_businesses_issues_on_business_id", using: :btree
    t.index ["issue_id"], name: "index_businesses_issues_on_issue_id", using: :btree
  end

  create_table "components", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_components_on_name", unique: true, using: :btree
  end

  create_table "components_issues", force: :cascade do |t|
    t.integer "component_id"
    t.integer "issue_id"
    t.index ["component_id"], name: "index_components_issues_on_component_id", using: :btree
    t.index ["issue_id"], name: "index_components_issues_on_issue_id", using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "hide",         default: false
    t.string   "status",       default: "active"
    t.string   "key"
    t.string   "display_name"
  end

  create_table "global_settings", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "base64_key"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["name"], name: "index_global_settings_on_name", unique: true, using: :btree
  end

  create_table "issue_histories", force: :cascade do |t|
    t.integer  "issue_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "employee_id"
    t.time     "duration"
    t.integer  "project_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "changelog_id_tag"
    t.integer  "status_id"
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "jira_id_tag"
    t.string   "issue_key"
    t.string   "title"
    t.boolean  "is_done",     default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "issue_type"
    t.datetime "done_date"
    t.integer  "project_id"
    t.index ["jira_id_tag", "issue_key"], name: "index_issues_on_jira_id_tag_and_issue_key", unique: true, using: :btree
    t.index ["project_id"], name: "index_issues_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "prefix"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_types", force: :cascade do |t|
    t.string   "report_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string   "name"
    t.date     "from_date"
    t.date     "to_date"
    t.json     "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_statuses_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "businesses_issues", "businesses"
  add_foreign_key "businesses_issues", "issues"
  add_foreign_key "components_issues", "components"
  add_foreign_key "components_issues", "issues"
  add_foreign_key "issues", "projects"
end
