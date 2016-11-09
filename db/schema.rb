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

ActiveRecord::Schema.define(version: 20161109055149) do

  create_table "campaigns", force: :cascade do |t|
    t.integer  "relative_id",  limit: 4,                   null: false
    t.integer  "webmaster_id", limit: 4,   default: 0
    t.string   "name",         limit: 255,                 null: false
    t.string   "description",  limit: 255
    t.string   "site_path",    limit: 255
    t.boolean  "enabled",                  default: false
    t.date     "start_date"
    t.date     "end_date"
    t.string   "question",     limit: 255,                 null: false
    t.boolean  "is_default",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",                  default: false
    t.string   "social_proof", limit: 255,                 null: false
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
  end

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
  end

  add_index "emoticons", ["is_default"], name: "index_emoticons_on_is_default", using: :btree
  add_index "emoticons", ["label"], name: "index_emoticons_on_label", using: :btree
  add_index "emoticons", ["sid"], name: "index_emoticons_on_sid", using: :btree

  create_table "impressions", force: :cascade do |t|
    t.integer  "customer_id", limit: 4,                       null: false
    t.datetime "created_at",                                  null: false
    t.string   "device_type", limit: 255, default: "Unknown"
  end

  add_index "impressions", ["created_at"], name: "index_impressions_on_created_at", using: :btree
  add_index "impressions", ["customer_id"], name: "index_impressions_on_customer_id", using: :btree
  add_index "impressions", ["device_type"], name: "index_impressions_on_device_type", using: :btree

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
    t.datetime "created_at",                                  null: false
    t.integer  "scenario_id", limit: 4,                       null: false
    t.integer  "customer_id", limit: 4,                       null: false
    t.string   "device_type", limit: 255, default: "Unknown"
  end

  add_index "reactions", ["created_at"], name: "index_reactions_on_created_at", using: :btree
  add_index "reactions", ["customer_id"], name: "index_reactions_on_customer_id", using: :btree
  add_index "reactions", ["device_type"], name: "index_reactions_on_device_type", using: :btree
  add_index "reactions", ["scenario_id"], name: "index_reactions_on_scenario_id", using: :btree

  create_table "scenarios", force: :cascade do |t|
    t.string  "label",       limit: 255
    t.string  "message",     limit: 255, default: "Thanks! You and {number} others feel this way."
    t.integer "emoticon_id", limit: 4
    t.boolean "enabled",                 default: false
    t.integer "campaign_id", limit: 4
  end

  add_index "scenarios", ["campaign_id"], name: "index_scenarios_on_campaign_id", using: :btree
  add_index "scenarios", ["emoticon_id"], name: "index_scenarios_on_emoticon_id", using: :btree
  add_index "scenarios", ["enabled"], name: "index_scenarios_on_enabled", using: :btree

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

  create_table "wp_commentmeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "comment_id", limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  add_index "wp_commentmeta", ["comment_id"], name: "comment_id", using: :btree
  add_index "wp_commentmeta", ["meta_key"], name: "meta_key", length: {"meta_key"=>191}, using: :btree

  create_table "wp_comments", primary_key: "comment_ID", force: :cascade do |t|
    t.integer  "comment_post_ID",      limit: 8,     default: 0,   null: false
    t.text     "comment_author",       limit: 255,                 null: false
    t.string   "comment_author_email", limit: 100,   default: "",  null: false
    t.string   "comment_author_url",   limit: 200,   default: "",  null: false
    t.string   "comment_author_IP",    limit: 100,   default: "",  null: false
    t.datetime "comment_date",                                     null: false
    t.datetime "comment_date_gmt",                                 null: false
    t.text     "comment_content",      limit: 65535,               null: false
    t.integer  "comment_karma",        limit: 4,     default: 0,   null: false
    t.string   "comment_approved",     limit: 20,    default: "1", null: false
    t.string   "comment_agent",        limit: 255,   default: "",  null: false
    t.string   "comment_type",         limit: 20,    default: "",  null: false
    t.integer  "comment_parent",       limit: 8,     default: 0,   null: false
    t.integer  "user_id",              limit: 8,     default: 0,   null: false
  end

  add_index "wp_comments", ["comment_approved", "comment_date_gmt"], name: "comment_approved_date_gmt", using: :btree
  add_index "wp_comments", ["comment_author_email"], name: "comment_author_email", length: {"comment_author_email"=>10}, using: :btree
  add_index "wp_comments", ["comment_date_gmt"], name: "comment_date_gmt", using: :btree
  add_index "wp_comments", ["comment_parent"], name: "comment_parent", using: :btree
  add_index "wp_comments", ["comment_post_ID"], name: "comment_post_ID", using: :btree

  create_table "wp_links", primary_key: "link_id", force: :cascade do |t|
    t.string   "link_url",         limit: 255,      default: "",  null: false
    t.string   "link_name",        limit: 255,      default: "",  null: false
    t.string   "link_image",       limit: 255,      default: "",  null: false
    t.string   "link_target",      limit: 25,       default: "",  null: false
    t.string   "link_description", limit: 255,      default: "",  null: false
    t.string   "link_visible",     limit: 20,       default: "Y", null: false
    t.integer  "link_owner",       limit: 8,        default: 1,   null: false
    t.integer  "link_rating",      limit: 4,        default: 0,   null: false
    t.datetime "link_updated",                                    null: false
    t.string   "link_rel",         limit: 255,      default: "",  null: false
    t.text     "link_notes",       limit: 16777215,               null: false
    t.string   "link_rss",         limit: 255,      default: "",  null: false
  end

  add_index "wp_links", ["link_visible"], name: "link_visible", using: :btree

  create_table "wp_options", primary_key: "option_id", force: :cascade do |t|
    t.string "option_name",  limit: 191,        default: "",    null: false
    t.text   "option_value", limit: 4294967295,                 null: false
    t.string "autoload",     limit: 20,         default: "yes", null: false
  end

  add_index "wp_options", ["option_name"], name: "option_name", unique: true, using: :btree

  create_table "wp_postmeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "post_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  add_index "wp_postmeta", ["meta_key"], name: "meta_key", length: {"meta_key"=>191}, using: :btree
  add_index "wp_postmeta", ["post_id"], name: "post_id", using: :btree

  create_table "wp_posts", primary_key: "ID", force: :cascade do |t|
    t.integer  "post_author",           limit: 8,          default: 0,         null: false
    t.datetime "post_date",                                                    null: false
    t.datetime "post_date_gmt",                                                null: false
    t.text     "post_content",          limit: 4294967295,                     null: false
    t.text     "post_title",            limit: 65535,                          null: false
    t.text     "post_excerpt",          limit: 65535,                          null: false
    t.string   "post_status",           limit: 20,         default: "publish", null: false
    t.string   "comment_status",        limit: 20,         default: "open",    null: false
    t.string   "ping_status",           limit: 20,         default: "open",    null: false
    t.string   "post_password",         limit: 20,         default: "",        null: false
    t.string   "post_name",             limit: 200,        default: "",        null: false
    t.text     "to_ping",               limit: 65535,                          null: false
    t.text     "pinged",                limit: 65535,                          null: false
    t.datetime "post_modified",                                                null: false
    t.datetime "post_modified_gmt",                                            null: false
    t.text     "post_content_filtered", limit: 4294967295,                     null: false
    t.integer  "post_parent",           limit: 8,          default: 0,         null: false
    t.string   "guid",                  limit: 255,        default: "",        null: false
    t.integer  "menu_order",            limit: 4,          default: 0,         null: false
    t.string   "post_type",             limit: 20,         default: "post",    null: false
    t.string   "post_mime_type",        limit: 100,        default: "",        null: false
    t.integer  "comment_count",         limit: 8,          default: 0,         null: false
  end

  add_index "wp_posts", ["post_author"], name: "post_author", using: :btree
  add_index "wp_posts", ["post_name"], name: "post_name", length: {"post_name"=>191}, using: :btree
  add_index "wp_posts", ["post_parent"], name: "post_parent", using: :btree
  add_index "wp_posts", ["post_type", "post_status", "post_date", "ID"], name: "type_status_date", using: :btree

  create_table "wp_term_relationships", id: false, force: :cascade do |t|
    t.integer "object_id",        limit: 8, default: 0, null: false
    t.integer "term_taxonomy_id", limit: 8, default: 0, null: false
    t.integer "term_order",       limit: 4, default: 0, null: false
  end

  add_index "wp_term_relationships", ["term_taxonomy_id"], name: "term_taxonomy_id", using: :btree

  create_table "wp_term_taxonomy", primary_key: "term_taxonomy_id", force: :cascade do |t|
    t.integer "term_id",     limit: 8,          default: 0,  null: false
    t.string  "taxonomy",    limit: 32,         default: "", null: false
    t.text    "description", limit: 4294967295,              null: false
    t.integer "parent",      limit: 8,          default: 0,  null: false
    t.integer "count",       limit: 8,          default: 0,  null: false
  end

  add_index "wp_term_taxonomy", ["taxonomy"], name: "taxonomy", using: :btree
  add_index "wp_term_taxonomy", ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true, using: :btree

  create_table "wp_termmeta", primary_key: "meta_id", force: :cascade do |t|
    t.integer "term_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  add_index "wp_termmeta", ["meta_key"], name: "meta_key", length: {"meta_key"=>191}, using: :btree
  add_index "wp_termmeta", ["term_id"], name: "term_id", using: :btree

  create_table "wp_terms", primary_key: "term_id", force: :cascade do |t|
    t.string  "name",       limit: 200, default: "", null: false
    t.string  "slug",       limit: 200, default: "", null: false
    t.integer "term_group", limit: 8,   default: 0,  null: false
  end

  add_index "wp_terms", ["name"], name: "name", length: {"name"=>191}, using: :btree
  add_index "wp_terms", ["slug"], name: "slug", length: {"slug"=>191}, using: :btree

  create_table "wp_usermeta", primary_key: "umeta_id", force: :cascade do |t|
    t.integer "user_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key",   limit: 255
    t.text    "meta_value", limit: 4294967295
  end

  add_index "wp_usermeta", ["meta_key"], name: "meta_key", length: {"meta_key"=>191}, using: :btree
  add_index "wp_usermeta", ["user_id"], name: "user_id", using: :btree

  create_table "wp_users", primary_key: "ID", force: :cascade do |t|
    t.string   "user_login",          limit: 60,  default: "", null: false
    t.string   "user_pass",           limit: 255, default: "", null: false
    t.string   "user_nicename",       limit: 50,  default: "", null: false
    t.string   "user_email",          limit: 100, default: "", null: false
    t.string   "user_url",            limit: 100, default: "", null: false
    t.datetime "user_registered",                              null: false
    t.string   "user_activation_key", limit: 255, default: "", null: false
    t.integer  "user_status",         limit: 4,   default: 0,  null: false
    t.string   "display_name",        limit: 250, default: "", null: false
  end

  add_index "wp_users", ["user_email"], name: "user_email", using: :btree
  add_index "wp_users", ["user_login"], name: "user_login_key", using: :btree
  add_index "wp_users", ["user_nicename"], name: "user_nicename", using: :btree

end
