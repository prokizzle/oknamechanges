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

ActiveRecord::Schema.define(version: 20150721020133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "code",              limit: 255
    t.string   "free_trial_length", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incoming_messages", force: :cascade do |t|
    t.text     "account"
    t.integer  "timestamp"
    t.text     "message_id"
    t.text     "username"
    t.string   "belongs_to", limit: 255
    t.time     "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incoming_messages", ["message_id", "account"], name: "index_incoming_messages_on_message_id_and_account", unique: true, using: :btree

  create_table "incoming_visits", force: :cascade do |t|
    t.text     "name"
    t.text     "account"
    t.text     "server_seqid"
    t.datetime "server_gmt"
  end

  create_table "matches", force: :cascade do |t|
    t.text     "name"
    t.text     "account"
    t.integer  "counts",                      default: 0
    t.integer  "last_visit",                  default: 0
    t.text     "gender"
    t.text     "sexuality"
    t.text     "city"
    t.text     "state"
    t.text     "added_from"
    t.integer  "match_percent",               default: 100
    t.float    "height"
    t.integer  "distance",                    default: 0
    t.integer  "enemy_percent",               default: 0
    t.integer  "last_online",                 default: 2086563760
    t.boolean  "inactive",                    default: false
    t.boolean  "ignored",                     default: false
    t.integer  "age",                         default: 25
    t.integer  "ages",                        default: 25
    t.time     "time"
    t.string   "thumb",           limit: 255
    t.time     "last_visit_time"
    t.string   "unique_key",      limit: 255
    t.string   "body_type",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["name", "account"], name: "index_matches_on_name_and_account", unique: true, using: :btree
  add_index "matches", ["name", "account"], name: "matches_name_account_index", using: :btree
  add_index "matches", ["name", "inactive"], name: "matches_name_inactive_index", using: :btree
  add_index "matches", ["unique_key"], name: "index_matches_on_unique_key", unique: true, using: :btree

  create_table "microposts", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "outgoing_visits", force: :cascade do |t|
    t.text     "name"
    t.text     "account"
    t.integer  "timestamp"
    t.time     "time"
    t.time     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "stripe_id",     limit: 255
    t.float    "price"
    t.string   "interval",      limit: 255
    t.text     "features"
    t.boolean  "highlight"
    t.integer  "display_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferences", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preferences", ["user_id"], name: "index_preferences_on_user_id", using: :btree

  create_table "schema_info", id: false, force: :cascade do |t|
    t.integer "version", default: 0, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",         limit: 255, null: false
    t.text     "value"
    t.integer  "target_id",               null: false
    t.string   "target_type", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true, using: :btree

  create_table "sidekiq_jobs", force: :cascade do |t|
    t.string   "jid",         limit: 255
    t.string   "queue",       limit: 255
    t.string   "class_name",  limit: 255
    t.text     "args"
    t.boolean  "retry"
    t.datetime "enqueued_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string   "status",      limit: 255
    t.string   "name",        limit: 255
    t.text     "result"
  end

  add_index "sidekiq_jobs", ["class_name"], name: "index_sidekiq_jobs_on_class_name", using: :btree
  add_index "sidekiq_jobs", ["enqueued_at"], name: "index_sidekiq_jobs_on_enqueued_at", using: :btree
  add_index "sidekiq_jobs", ["finished_at"], name: "index_sidekiq_jobs_on_finished_at", using: :btree
  add_index "sidekiq_jobs", ["jid"], name: "index_sidekiq_jobs_on_jid", using: :btree
  add_index "sidekiq_jobs", ["queue"], name: "index_sidekiq_jobs_on_queue", using: :btree
  add_index "sidekiq_jobs", ["retry"], name: "index_sidekiq_jobs_on_retry", using: :btree
  add_index "sidekiq_jobs", ["started_at"], name: "index_sidekiq_jobs_on_started_at", using: :btree
  add_index "sidekiq_jobs", ["status"], name: "index_sidekiq_jobs_on_status", using: :btree

  create_table "stats", force: :cascade do |t|
    t.integer "total_visits"
    t.integer "total_visitors"
    t.integer "new_users"
    t.integer "total_messages"
    t.text    "account"
  end

  add_index "stats", ["new_users", "account"], name: "stats_new_users_account_index", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.string   "stripe_id",     limit: 255
    t.integer  "plan_id"
    t.string   "last_four",     limit: 255
    t.integer  "coupon_id"
    t.string   "card_type",     limit: 255
    t.float    "current_price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "username_changes", force: :cascade do |t|
    t.text     "old_name"
    t.text     "new_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "username_changes", ["old_name", "new_name", "id"], name: "username_changes_old_name_new_name_id_index", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",                  default: 0
    t.string   "stripe_id",              limit: 255
    t.boolean  "subscribed"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id", "invited_by_type"], name: "index_users_on_invited_by_id_and_invited_by_type", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
