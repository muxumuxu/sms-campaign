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

ActiveRecord::Schema.define(version: 20170126104602) do

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
    t.index ["campaign_id"], name: "index_campaigns_mailing_lists_on_campaign_id"
    t.index ["mailing_list_id"], name: "index_campaigns_mailing_lists_on_mailing_list_id"
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
    t.index ["contact_id"], name: "index_contacts_mailing_lists_on_contact_id"
    t.index ["mailing_list_id"], name: "index_contacts_mailing_lists_on_mailing_list_id"
  end

  create_table "mailing_lists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
