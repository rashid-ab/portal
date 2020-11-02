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

ActiveRecord::Schema.define(version: 20201102111424) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "advertisements", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id", using: :btree
    t.index ["author_type", "author_id"], name: "index_attachments_on_author_type_and_author_id", using: :btree
  end

  create_table "blocked_advertisements", id: false, force: :cascade do |t|
    t.integer "advertisement_id"
    t.integer "company_id"
    t.index ["advertisement_id"], name: "index_blocked_advertisements_on_advertisement_id", using: :btree
    t.index ["company_id"], name: "index_blocked_advertisements_on_company_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "marketing_manager_id"
    t.integer  "development_manager_id"
    t.index ["development_manager_id"], name: "index_companies_on_development_manager_id", using: :btree
    t.index ["marketing_manager_id"], name: "index_companies_on_marketing_manager_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "company_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "phone"
    t.boolean  "email_updates"
    t.boolean  "show_welcome_section",   default: true
    t.index ["company_id"], name: "index_contacts_on_company_id", using: :btree
    t.index ["email"], name: "index_contacts_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_contacts_on_reset_password_token", unique: true, using: :btree
  end

  create_table "helps", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "logins", force: :cascade do |t|
    t.string   "title"
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "url"
    t.text     "notes"
    t.integer  "login_type"
    t.string   "port"
    t.string   "host"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_logins_on_company_id", using: :btree
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "subdomain"
    t.string   "phone"
    t.string   "logo_url"
    t.string   "time_zone"
    t.string   "primary_color"
    t.string   "secondary_color"
  end

  create_table "project_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_types_resources", id: false, force: :cascade do |t|
    t.integer "resource_id"
    t.integer "project_type_id"
    t.index ["project_type_id"], name: "index_project_types_resources_on_project_type_id", using: :btree
    t.index ["resource_id"], name: "index_project_types_resources_on_resource_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "project_type_id"
    t.integer  "project_status_id"
    t.date     "target_completion_date"
    t.boolean  "completion_date_visible"
    t.text     "notes"
    t.integer  "percent_complete"
    t.index ["company_id"], name: "index_projects_on_company_id", using: :btree
    t.index ["project_status_id"], name: "index_projects_on_project_status_id", using: :btree
    t.index ["project_type_id"], name: "index_projects_on_project_type_id", using: :btree
  end

  create_table "reports", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "service_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "notify"
    t.index ["service_id"], name: "index_reports_on_service_id", using: :btree
  end

  create_table "resources", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.text     "content"
    t.string   "version"
    t.string   "admin_notes"
    t.string   "thumbnail_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "service_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_types_resources", id: false, force: :cascade do |t|
    t.integer "resource_id"
    t.integer "service_type_id"
    t.index ["resource_id"], name: "index_service_types_resources_on_resource_id", using: :btree
    t.index ["service_type_id"], name: "index_service_types_resources_on_service_type_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.integer  "service_type_id"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "company_id"
    t.index ["company_id"], name: "index_services_on_company_id", using: :btree
    t.index ["service_type_id"], name: "index_services_on_service_type_id", using: :btree
  end

  create_table "todos", force: :cascade do |t|
    t.string   "name"
    t.date     "due_date"
    t.integer  "subject_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "subject_type"
    t.integer  "status",       default: 0
    t.datetime "submitted_at"
    t.datetime "closed_at"
    t.text     "description"
    t.index ["subject_id"], name: "index_todos_on_subject_id", using: :btree
    t.index ["subject_type"], name: "index_todos_on_subject_type", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "organization_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "favorite_quote"
    t.text     "bio"
    t.string   "office_phone"
    t.string   "cell_phone"
    t.string   "avatar_url"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["organization_id"], name: "index_users_on_organization_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "welcome_sections", force: :cascade do |t|
    t.string   "welcome_text"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "companies", "users", column: "development_manager_id"
  add_foreign_key "companies", "users", column: "marketing_manager_id"
  add_foreign_key "contacts", "companies"
  add_foreign_key "logins", "companies"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "project_statuses"
  add_foreign_key "projects", "project_types"
  add_foreign_key "reports", "services"
  add_foreign_key "services", "companies"
  add_foreign_key "services", "service_types"
  add_foreign_key "users", "organizations"
end
