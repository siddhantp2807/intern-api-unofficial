# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_24_140050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "offers", force: :cascade do |t|
    t.string "base"
    t.string "header"
    t.string "url"
    t.string "co_name"
    t.string "locus", array: true
    t.string "begin_date", array: true
    t.string "duration"
    t.string "pay_struct"
    t.string "min_pay"
    t.string "max_pay"
    t.string "exp_str"
    t.datetime "exp_stamp"
    t.string "co_url"
    t.integer "applicants"
    t.integer "openings"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tags", array: true
  end

  create_table "offers_tags", id: false, force: :cascade do |t|
    t.bigint "offer_id", null: false
    t.bigint "tag_id", null: false
    t.index ["offer_id", "tag_id"], name: "index_offers_tags_on_offer_id_and_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
