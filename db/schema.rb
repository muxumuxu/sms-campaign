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

ActiveRecord::Schema.define(version: 20170126162537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_on"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaigns_mailing_lists", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "mailing_list_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["campaign_id"], name: "index_campaigns_mailing_lists_on_campaign_id", using: :btree
    t.index ["mailing_list_id"], name: "index_campaigns_mailing_lists_on_mailing_list_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zip_code"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "contacts_mailing_lists", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "mailing_list_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["contact_id"], name: "index_contacts_mailing_lists_on_contact_id", using: :btree
    t.index ["mailing_list_id"], name: "index_contacts_mailing_lists_on_mailing_list_id", using: :btree
  end

  create_table "mailing_lists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "campaigns_mailing_lists", "campaigns"
  add_foreign_key "campaigns_mailing_lists", "mailing_lists"
  add_foreign_key "contacts_mailing_lists", "contacts"
  add_foreign_key "contacts_mailing_lists", "mailing_lists"
end
