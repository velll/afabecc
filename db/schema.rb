# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_09_140632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "endpoint_responses", force: :cascade do |t|
    t.bigint "endpoint_id"
    t.integer "code"
    t.jsonb "headers", default: {}
    t.string "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["endpoint_id"], name: "index_endpoint_responses_on_endpoint_id"
  end

  create_table "endpoints", force: :cascade do |t|
    t.string "verb"
    t.string "path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
