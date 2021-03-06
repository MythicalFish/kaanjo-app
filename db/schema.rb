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

ActiveRecord::Schema.define(version: 20170125153701) do

  create_table "campaigns", force: :cascade do |t|
    t.integer  "relative_id",    limit: 4,                   null: false
    t.integer  "webmaster_id",   limit: 4,   default: 0
    t.string   "name",           limit: 255,                 null: false
    t.string   "description",    limit: 255
    t.string   "site_path",      limit: 255
    t.boolean  "enabled",                    default: false
    t.date     "start_date"
    t.date     "end_date"
    t.string   "question",       limit: 255,                 null: false
    t.boolean  "is_default",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",                    default: false
    t.string   "social_proof",   limit: 255,                 null: false
    t.integer  "products_count", limit: 4
  end

  add_index "campaigns", ["created_at"], name: "index_campaigns_on_created_at", using: :btree
  add_index "campaigns", ["deleted"], name: "index_campaigns_on_deleted", using: :btree
  add_index "campaigns", ["enabled"], name: "index_campaigns_on_enabled", using: :btree
  add_index "campaigns", ["is_default"], name: "index_campaigns_on_is_default", using: :btree
  add_index "campaigns", ["relative_id"], name: "index_campaigns_on_relative_id", using: :btree
  add_index "campaigns", ["webmaster_id"], name: "index_campaigns_on_webmaster_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "sid",              limit: 255,             null: false
    t.string   "ip_address",       limit: 255
    t.integer  "throttle_index_1", limit: 4,   default: 0
    t.datetime "throttle_timer_1"
    t.integer  "campaign_id",      limit: 4
  end

  add_index "customers", ["campaign_id"], name: "index_customers_on_campaign_id", using: :btree
  add_index "customers", ["ip_address"], name: "index_customers_on_ip_address", using: :btree
  add_index "customers", ["sid"], name: "index_customers_on_sid", using: :btree

  create_table "emoticons", force: :cascade do |t|
    t.string   "label",              limit: 255,                 null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "sid",                limit: 255,                 null: false
    t.string   "message",            limit: 255
    t.boolean  "is_default",                     default: false
    t.string   "category",           limit: 255
  end

  add_index "emoticons", ["category"], name: "index_emoticons_on_category", using: :btree
  add_index "emoticons", ["is_default"], name: "index_emoticons_on_is_default", using: :btree
  add_index "emoticons", ["label"], name: "index_emoticons_on_label", using: :btree
  add_index "emoticons", ["sid"], name: "index_emoticons_on_sid", using: :btree

  create_table "impressions", force: :cascade do |t|
    t.integer  "product_id",  limit: 4,                         null: false
    t.integer  "customer_id", limit: 4,                         null: false
    t.datetime "created_at",                                    null: false
    t.string   "device_type", limit: 255, default: "Not given"
  end

  add_index "impressions", ["created_at"], name: "index_impressions_on_created_at", using: :btree
  add_index "impressions", ["customer_id"], name: "index_impressions_on_customer_id", using: :btree
  add_index "impressions", ["device_type"], name: "index_impressions_on_device_type", using: :btree
  add_index "impressions", ["product_id"], name: "index_impressions_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "url",         limit: 255, null: false
    t.datetime "created_at",              null: false
    t.string   "sid",         limit: 255, null: false
    t.integer  "campaign_id", limit: 4,   null: false
  end

  add_index "products", ["campaign_id"], name: "index_products_on_campaign_id", using: :btree
  add_index "products", ["created_at"], name: "index_products_on_created_at", using: :btree
  add_index "products", ["name"], name: "index_products_on_name", using: :btree
  add_index "products", ["sid"], name: "index_products_on_sid", using: :btree

  create_table "reactions", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.integer  "scenario_id",   limit: 4, null: false
    t.integer  "impression_id", limit: 4, null: false
    t.integer  "product_id",    limit: 4, null: false
    t.integer  "customer_id",   limit: 4, null: false
  end

  add_index "reactions", ["created_at"], name: "index_reactions_on_created_at", using: :btree
  add_index "reactions", ["customer_id"], name: "index_reactions_on_customer_id", using: :btree
  add_index "reactions", ["impression_id"], name: "index_reactions_on_impression_id", using: :btree
  add_index "reactions", ["product_id"], name: "index_reactions_on_product_id", using: :btree
  add_index "reactions", ["scenario_id"], name: "index_reactions_on_scenario_id", using: :btree

  create_table "scenarios", force: :cascade do |t|
    t.string   "label",                        limit: 255
    t.string   "message",                      limit: 255, default: "Thanks! You and {number} others feel this way."
    t.integer  "emoticon_id",                  limit: 4
    t.boolean  "enabled",                                  default: false
    t.integer  "campaign_id",                  limit: 4
    t.string   "custom_emoticon_file_name",    limit: 255
    t.string   "custom_emoticon_content_type", limit: 255
    t.integer  "custom_emoticon_file_size",    limit: 4
    t.datetime "custom_emoticon_updated_at"
    t.string   "sid",                          limit: 255,                                                            null: false
  end

  add_index "scenarios", ["campaign_id"], name: "index_scenarios_on_campaign_id", using: :btree
  add_index "scenarios", ["emoticon_id"], name: "index_scenarios_on_emoticon_id", using: :btree
  add_index "scenarios", ["enabled"], name: "index_scenarios_on_enabled", using: :btree
  add_index "scenarios", ["sid"], name: "index_scenarios_on_sid", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "admin",                              default: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "website_url",            limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "website_name",           limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "title",                  limit: 255
    t.string   "address1",               limit: 255
    t.string   "address2",               limit: 255
    t.string   "city",                   limit: 255
    t.string   "postcode",               limit: 255
    t.string   "country",                limit: 255
    t.string   "phone",                  limit: 255
    t.string   "sid",                    limit: 255
    t.integer  "throttle_index_1",       limit: 4,   default: 0
    t.datetime "throttle_timer_1"
    t.boolean  "creation_enabled",                   default: true
  end

  add_index "users", ["admin"], name: "index_users_on_admin", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["sid"], name: "index_users_on_sid", using: :btree
  add_index "users", ["website_url"], name: "index_users_on_website_url", using: :btree

end
