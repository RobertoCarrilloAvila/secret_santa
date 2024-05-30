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

ActiveRecord::Schema[7.0].define(version: 2024_05_30_052941) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gift_assigments", force: :cascade do |t|
    t.bigint "giver_id", null: false
    t.bigint "recipient_id", null: false
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["giver_id", "recipient_id", "year"], name: "index_gift_assigments_on_giver_id_and_recipient_id_and_year", unique: true
    t.index ["giver_id"], name: "index_gift_assigments_on_giver_id"
    t.index ["recipient_id"], name: "index_gift_assigments_on_recipient_id"
  end

  create_table "people", force: :cascade do |t|
    t.bigint "family_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_people_on_family_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "linked_person_id", null: false
    t.string "relationship_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linked_person_id"], name: "index_relationships_on_linked_person_id"
    t.index ["person_id", "linked_person_id"], name: "index_relationships_on_person_id_and_linked_person_id", unique: true
    t.index ["person_id"], name: "index_relationships_on_person_id"
  end

  add_foreign_key "gift_assigments", "people", column: "giver_id"
  add_foreign_key "gift_assigments", "people", column: "recipient_id"
  add_foreign_key "people", "families"
  add_foreign_key "relationships", "people"
  add_foreign_key "relationships", "people", column: "linked_person_id"
end
