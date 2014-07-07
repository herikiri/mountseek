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

ActiveRecord::Schema.define(version: 20140707160212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", force: true do |t|
    t.integer  "user_id"
    t.integer  "adable_id"
    t.string   "adable_type"
    t.integer  "package_id"
    t.string   "status"
    t.integer  "picture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ads", ["package_id"], name: "index_ads_on_package_id", using: :btree
  add_index "ads", ["user_id"], name: "index_ads_on_user_id", using: :btree

  create_table "ai_type_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checked"
  end

  create_table "breed_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checked"
  end

  create_table "color_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "condition_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discipline_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disciplines", force: true do |t|
    t.string   "name"
    t.string   "experience"
    t.integer  "discipline_id"
    t.string   "discipline_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experience_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gender_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checked"
  end

  create_table "horses", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.decimal  "price"
    t.boolean  "private_treaty"
    t.string   "ad_for"
    t.string   "name"
    t.string   "gender"
    t.string   "breed"
    t.date     "birth"
    t.string   "color"
    t.decimal  "height"
    t.decimal  "weight"
    t.integer  "package_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "banner"
    t.date     "published_at"
    t.date     "published_end"
    t.integer  "views_count"
    t.string   "registration"
    t.integer  "registration_num"
    t.string   "second_reg"
    t.integer  "second_reg_num"
    t.string   "other_markings"
    t.string   "second_breed"
    t.string   "temperament"
    t.string   "user_name"
    t.string   "farm_name"
    t.string   "website"
    t.string   "email"
    t.string   "phone_number"
    t.string   "alt_phone_number"
    t.decimal  "latitude"
    t.decimal  "longtitude"
    t.string   "country"
    t.string   "viewport"
  end

  add_index "horses", ["package_id"], name: "index_horses_on_package_id", using: :btree
  add_index "horses", ["user_id"], name: "index_horses_on_user_id", using: :btree

  create_table "house_type_options", force: true do |t|
    t.string   "name"
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree

  create_table "packages", force: true do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "duration"
    t.integer  "max_photo_upload"
    t.integer  "max_video_upload"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "name"
    t.string   "farm_name"
    t.string   "phone_number"
    t.string   "alt_phone_number"
    t.string   "website"
    t.string   "zipcode"
    t.string   "city"
    t.string   "state"
    t.text     "about"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "real_estates", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "zip_code"
    t.string   "country_location"
    t.string   "city"
    t.string   "state"
    t.decimal  "price"
    t.boolean  "private_treaty"
    t.string   "ad_for"
    t.string   "house_type"
    t.string   "house_style"
    t.date     "year"
    t.decimal  "sqft"
    t.integer  "bedroom"
    t.integer  "floor"
    t.integer  "garage"
    t.integer  "bathroom"
    t.integer  "package_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "banner"
    t.date     "published_at"
    t.date     "published_end"
    t.integer  "views_count"
    t.string   "user_name"
    t.string   "farm_name"
    t.string   "website"
    t.string   "email"
    t.string   "phone_number"
    t.string   "alt_phone_number"
    t.decimal  "latitude"
    t.decimal  "longtitude"
    t.string   "viewport"
    t.integer  "deeded_acres"
    t.integer  "irrigated_acres"
    t.integer  "leased_acres"
    t.integer  "total_acres"
  end

  add_index "real_estates", ["package_id"], name: "index_real_estates_on_package_id", using: :btree
  add_index "real_estates", ["user_id"], name: "index_real_estates_on_user_id", using: :btree

  create_table "rideabilities", force: true do |t|
    t.string   "name"
    t.integer  "horse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rideability_option_id"
  end

  add_index "rideabilities", ["horse_id"], name: "index_rideabilities_on_horse_id", using: :btree

  create_table "rideability_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_type_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "company"
    t.text     "company_description"
    t.integer  "package_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "banner"
    t.date     "published_at"
    t.date     "published_end"
    t.integer  "views_count"
    t.string   "user_name"
    t.string   "farm_name"
    t.string   "website"
    t.string   "email"
    t.string   "phone_number"
    t.string   "alt_phone_number"
    t.decimal  "latitude"
    t.decimal  "longtitude"
    t.string   "country"
    t.string   "viewport"
    t.string   "service_type"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
  end

  add_index "services", ["package_id"], name: "index_services_on_package_id", using: :btree
  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "state_options", force: true do |t|
    t.string   "name"
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studs", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.boolean  "private_treaty"
    t.string   "name"
    t.string   "breed"
    t.date     "birth"
    t.string   "color"
    t.decimal  "height"
    t.decimal  "weight"
    t.integer  "package_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "banner"
    t.date     "published_at"
    t.date     "published_end"
    t.integer  "views_count"
    t.string   "registration"
    t.integer  "registration_num"
    t.string   "second_reg"
    t.integer  "second_reg_num"
    t.string   "other_markings"
    t.string   "second_breed"
    t.string   "temperament"
    t.decimal  "stud_fee"
    t.decimal  "booking_fee"
    t.decimal  "shipping_fee"
    t.date     "available"
    t.date     "until"
    t.string   "ai_type"
    t.string   "user_name"
    t.string   "farm_name"
    t.string   "website"
    t.string   "email"
    t.string   "phone_number"
    t.string   "alt_phone_number"
    t.decimal  "latitude"
    t.decimal  "longtitude"
    t.string   "country"
    t.string   "viewport"
    t.decimal  "price"
    t.string   "gender"
  end

  add_index "studs", ["package_id"], name: "index_studs_on_package_id", using: :btree
  add_index "studs", ["user_id"], name: "index_studs_on_user_id", using: :btree

  create_table "tack_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tack_type_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tacks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price"
    t.string   "tack"
    t.string   "tack_type"
    t.string   "discipline"
    t.string   "condition"
    t.string   "color"
    t.integer  "package_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "banner"
    t.date     "published_at"
    t.date     "published_end"
    t.integer  "views_count"
    t.string   "user_name"
    t.string   "farm_name"
    t.string   "website"
    t.string   "email"
    t.string   "phone_number"
    t.string   "alt_phone_number"
    t.decimal  "latitude"
    t.decimal  "longtitude"
    t.string   "country"
    t.string   "viewport"
  end

  add_index "tacks", ["package_id"], name: "index_tacks_on_package_id", using: :btree
  add_index "tacks", ["user_id"], name: "index_tacks_on_user_id", using: :btree

  create_table "temperament_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trailers", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.decimal  "price"
    t.boolean  "private_treaty"
    t.string   "brand"
    t.string   "model"
    t.date     "year"
    t.string   "material"
    t.string   "color"
    t.string   "hitch"
    t.string   "axles"
    t.integer  "hauls"
    t.integer  "package_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "latitude"
    t.decimal  "longtitude"
    t.string   "country"
    t.string   "viewport"
    t.string   "user_name"
    t.string   "farm_name"
    t.string   "website"
    t.string   "email"
    t.string   "phone_number"
    t.string   "alt_phone_number"
    t.string   "status"
    t.integer  "banner"
    t.date     "published_at"
    t.date     "published_end"
    t.integer  "views_count"
  end

  add_index "trailers", ["package_id"], name: "index_trailers_on_package_id", using: :btree
  add_index "trailers", ["user_id"], name: "index_trailers_on_user_id", using: :btree

  create_table "types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_pictures", force: true do |t|
    t.string   "avatar"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.string   "name"
    t.integer  "videoable_id"
    t.string   "videoable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.string   "category"
    t.string   "keywords"
    t.string   "link"
    t.string   "uid"
    t.string   "author"
    t.string   "duration"
    t.integer  "likes"
    t.integer  "dislikes"
  end

  add_index "videos", ["uid"], name: "index_videos_on_uid", unique: true, using: :btree

  create_table "votes", force: true do |t|
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

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", name: "mb_opt_outs_on_conversations_id", column: "conversation_id"

  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", name: "notifications_on_conversation_id", column: "conversation_id"

  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", name: "receipts_on_notification_id", column: "notification_id"

end
