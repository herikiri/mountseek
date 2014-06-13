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

ActiveRecord::Schema.define(version: 20140613104533) do

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

  add_index "ads", ["adable_id"], name: "index_ads_on_adable_id", using: :btree
  add_index "ads", ["adable_type"], name: "index_ads_on_adable_type", using: :btree
  add_index "ads", ["package_id"], name: "index_ads_on_package_id", using: :btree
  add_index "ads", ["user_id"], name: "index_ads_on_user_id", using: :btree

  create_table "disciplines", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disciplines_services", id: false, force: true do |t|
    t.integer  "service_id"
    t.integer  "discipline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disciplines_services", ["discipline_id"], name: "index_disciplines_services_on_discipline_id", using: :btree
  add_index "disciplines_services", ["service_id"], name: "index_disciplines_services_on_service_id", using: :btree

  create_table "disciplines_tacks", force: true do |t|
    t.integer  "tack_id"
    t.integer  "discipline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "disciplines_tacks", ["discipline_id"], name: "index_disciplines_tacks_on_discipline_id", using: :btree
  add_index "disciplines_tacks", ["tack_id"], name: "index_disciplines_tacks_on_tack_id", using: :btree

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
  end

  add_index "horses", ["package_id"], name: "index_horses_on_package_id", using: :btree
  add_index "horses", ["user_id"], name: "index_horses_on_user_id", using: :btree

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

  add_index "pictures", ["imageable_id"], name: "index_pictures_on_imageable_id", using: :btree
  add_index "pictures", ["imageable_type"], name: "index_pictures_on_imageable_type", using: :btree

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
  end

  add_index "real_estates", ["package_id"], name: "index_real_estates_on_package_id", using: :btree
  add_index "real_estates", ["user_id"], name: "index_real_estates_on_user_id", using: :btree

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
  end

  add_index "services", ["package_id"], name: "index_services_on_package_id", using: :btree
  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "studs", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.decimal  "price"
    t.boolean  "private_treaty"
    t.string   "ad_for"
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
  end

  add_index "studs", ["package_id"], name: "index_studs_on_package_id", using: :btree
  add_index "studs", ["user_id"], name: "index_studs_on_user_id", using: :btree

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
  end

  add_index "tacks", ["package_id"], name: "index_tacks_on_package_id", using: :btree
  add_index "tacks", ["user_id"], name: "index_tacks_on_user_id", using: :btree

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
  end

  add_index "videos", ["videoable_id"], name: "index_videos_on_videoable_id", using: :btree
  add_index "videos", ["videoable_type"], name: "index_videos_on_videoable_type", using: :btree

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

end
