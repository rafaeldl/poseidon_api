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

ActiveRecord::Schema.define(version: 20141028203837) do

  create_table "", force: true do |t|
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entities", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "header_id"
    t.integer  "multiplicity"
  end

  add_index "entities", ["company_id"], name: "index_entities_on_company_id"
  add_index "entities", ["header_id"], name: "index_entities_on_header_id"

  create_table "fields", force: true do |t|
    t.integer  "company_id"
    t.integer  "entity_id"
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.string   "kind"
    t.string   "mask"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "size"
    t.boolean  "show_query"
    t.boolean  "show_index"
    t.string   "show_in"
    t.integer  "order"
    t.string   "options"
    t.string   "default"
    t.integer  "foreign_entity"
    t.string   "foreign_filter"
    t.string   "visibility",     limit: 1
    t.boolean  "editable"
    t.integer  "scale"
    t.boolean  "required"
  end

  add_index "fields", ["company_id"], name: "index_fields_on_company_id"
  add_index "fields", ["entity_id"], name: "index_fields_on_entity_id"
  add_index "fields", ["foreign_entity"], name: "index_fields_on_foreign_entity"

  create_table "modulo", force: true do |t|
    t.integer "entity_id"
    t.string  "nome"
    t.string  "descricao"
    t.boolean "habilitado"
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
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
