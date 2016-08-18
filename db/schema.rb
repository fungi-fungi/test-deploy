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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "_hcmeta", force: :cascade do |t|
    t.string  "org_id",  limit: 50
    t.integer "hcver"
    t.text    "details"
  end

  create_table "account", force: :cascade do |t|
    t.text     "_hc_err"
    t.string   "name",           limit: 255
    t.string   "_hc_lastop",     limit: 32
    t.string   "accountnumber",  limit: 40
    t.string   "sfid",           limit: 18
    t.boolean  "isdeleted"
    t.datetime "systemmodstamp"
    t.datetime "createddate"
    t.string   "phone",          limit: 40
    t.string   "recordtypeid",   limit: 18
    t.text     "description"
  end

  add_index "account", ["recordtypeid"], name: "hc_idx_account_recordtypeid", using: :btree
  add_index "account", ["sfid"], name: "hcu_idx_account_sfid", unique: true, using: :btree
  add_index "account", ["systemmodstamp"], name: "hc_idx_account_systemmodstamp", using: :btree

  create_table "i_m__bom__c", force: :cascade do |t|
    t.text     "_hc_err"
    t.string   "name",           limit: 80
    t.string   "sfid",           limit: 18
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.string   "_hc_lastop",     limit: 32
    t.boolean  "isdeleted"
  end

  add_index "i_m__bom__c", ["sfid"], name: "hcu_idx_i_m__bom__c_sfid", unique: true, using: :btree
  add_index "i_m__bom__c", ["systemmodstamp"], name: "hc_idx_i_m__bom__c_systemmodstamp", using: :btree

  create_table "i_m__category__c", force: :cascade do |t|
    t.string   "_hc_lastop",         limit: 32
    t.string   "sfid",               limit: 18
    t.datetime "createddate"
    t.boolean  "isdeleted"
    t.text     "_hc_err"
    t.float    "i_m__externalid__c"
    t.string   "name",               limit: 80
    t.datetime "systemmodstamp"
  end

  add_index "i_m__category__c", ["i_m__externalid__c"], name: "hcu_idx_i_m__category__c_i_m__externalid__c", unique: true, using: :btree
  add_index "i_m__category__c", ["sfid"], name: "hcu_idx_i_m__category__c_sfid", unique: true, using: :btree
  add_index "i_m__category__c", ["systemmodstamp"], name: "hc_idx_i_m__category__c_systemmodstamp", using: :btree

  create_table "i_m__category_entity__c", force: :cascade do |t|
    t.string   "i_m__to_category__c",     limit: 18
    t.text     "_hc_err"
    t.string   "name",                    limit: 80
    t.string   "i_m__to_category_set__c", limit: 18
    t.string   "_hc_lastop",              limit: 32
    t.datetime "createddate"
    t.string   "sfid",                    limit: 18
    t.boolean  "isdeleted"
    t.datetime "systemmodstamp"
  end

  add_index "i_m__category_entity__c", ["i_m__to_category__c"], name: "hc_idx_i_m__category_entity__c_i_m__to_category__c", using: :btree
  add_index "i_m__category_entity__c", ["i_m__to_category_set__c"], name: "hc_idx_i_m__category_entity__c_i_m__to_category_set__c", using: :btree
  add_index "i_m__category_entity__c", ["sfid"], name: "hcu_idx_i_m__category_entity__c_sfid", unique: true, using: :btree
  add_index "i_m__category_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__category_entity__c_systemmodstamp", using: :btree

  create_table "i_m__category_set__c", force: :cascade do |t|
    t.boolean  "isdeleted"
    t.datetime "createddate"
    t.string   "_hc_lastop",     limit: 32
    t.string   "sfid",           limit: 18
    t.text     "_hc_err"
    t.datetime "systemmodstamp"
    t.string   "name",           limit: 80
  end

  add_index "i_m__category_set__c", ["sfid"], name: "hcu_idx_i_m__category_set__c_sfid", unique: true, using: :btree
  add_index "i_m__category_set__c", ["systemmodstamp"], name: "hc_idx_i_m__category_set__c_systemmodstamp", using: :btree

  create_table "i_m__configuration__c", force: :cascade do |t|
    t.text     "_hc_err"
    t.string   "name",                    limit: 80
    t.string   "i_m__to_category_set__c", limit: 18
    t.string   "_hc_lastop",              limit: 32
    t.string   "i_m__to_account__c",      limit: 18
    t.string   "i_m__to_bom__c",          limit: 18
    t.datetime "createddate"
    t.string   "sfid",                    limit: 18
    t.boolean  "isdeleted"
    t.datetime "systemmodstamp"
  end

  add_index "i_m__configuration__c", ["i_m__to_account__c"], name: "hc_idx_i_m__configuration__c_i_m__to_account__c", using: :btree
  add_index "i_m__configuration__c", ["i_m__to_bom__c"], name: "hc_idx_i_m__configuration__c_i_m__to_bom__c", using: :btree
  add_index "i_m__configuration__c", ["i_m__to_category_set__c"], name: "hc_idx_i_m__configuration__c_i_m__to_category_set__c", using: :btree
  add_index "i_m__configuration__c", ["sfid"], name: "hcu_idx_i_m__configuration__c_sfid", unique: true, using: :btree
  add_index "i_m__configuration__c", ["systemmodstamp"], name: "hc_idx_i_m__configuration__c_systemmodstamp", using: :btree

  create_table "i_m__item__c", force: :cascade do |t|
    t.string   "_hc_lastop",                           limit: 32
    t.datetime "createddate"
    t.string   "sfid",                                 limit: 18
    t.float    "i_m__category__c__i_m__externalid__c"
    t.string   "name",                                 limit: 80
    t.text     "_hc_err"
    t.string   "i_m__to_category__c",                  limit: 18
    t.string   "i_m__description__c",                  limit: 250
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
  end

  add_index "i_m__item__c", ["i_m__category__c__i_m__externalid__c"], name: "hc_idx_i_m__item__c_i_m__category__c__i_m__externalid__c", using: :btree
  add_index "i_m__item__c", ["i_m__to_category__c"], name: "hc_idx_i_m__item__c_i_m__to_category__c", using: :btree
  add_index "i_m__item__c", ["sfid"], name: "hcu_idx_i_m__item__c_sfid", unique: true, using: :btree
  add_index "i_m__item__c", ["systemmodstamp"], name: "hc_idx_i_m__item__c_systemmodstamp", using: :btree

  create_table "i_m__item_entity__c", force: :cascade do |t|
    t.boolean  "isdeleted"
    t.datetime "systemmodstamp"
    t.float    "i_m__amount__c"
    t.datetime "createddate"
    t.string   "sfid",            limit: 18
    t.string   "_hc_lastop",      limit: 32
    t.string   "i_m__to_bom__c",  limit: 18
    t.text     "_hc_err"
    t.string   "name",            limit: 80
    t.string   "i_m__to_item__c", limit: 18
  end

  add_index "i_m__item_entity__c", ["i_m__to_bom__c"], name: "hc_idx_i_m__item_entity__c_i_m__to_bom__c", using: :btree
  add_index "i_m__item_entity__c", ["i_m__to_item__c"], name: "hc_idx_i_m__item_entity__c_i_m__to_item__c", using: :btree
  add_index "i_m__item_entity__c", ["sfid"], name: "hcu_idx_i_m__item_entity__c_sfid", unique: true, using: :btree
  add_index "i_m__item_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__item_entity__c_systemmodstamp", using: :btree

  create_table "i_m__order_request__c", force: :cascade do |t|
    t.datetime "systemmodstamp"
    t.string   "i_m__to_event__c",                           limit: 18
    t.boolean  "isdeleted"
    t.text     "_hc_err"
    t.string   "i_m__to_request_bom__c",                     limit: 18
    t.string   "sfid",                                       limit: 18
    t.string   "i_m__to_account__c",                         limit: 18
    t.datetime "createddate"
    t.string   "_hc_lastop",                                 limit: 32
    t.string   "name",                                       limit: 80
    t.float    "i_m__to_request_bom__r__i_m__externalid__c"
  end

  add_index "i_m__order_request__c", ["i_m__to_request_bom__c"], name: "hc_idx_i_m__order_request__c_i_m__to_request_bom__c", using: :btree
  add_index "i_m__order_request__c", ["i_m__to_request_bom__r__i_m__externalid__c"], name: "hc_idx_i_m__order_request__c_i_m__to_request_bom__r__i__0be1", using: :btree
  add_index "i_m__order_request__c", ["sfid"], name: "hcu_idx_i_m__order_request__c_sfid", unique: true, using: :btree
  add_index "i_m__order_request__c", ["systemmodstamp"], name: "hc_idx_i_m__order_request__c_systemmodstamp", using: :btree

  create_table "i_m__request_bom__c", force: :cascade do |t|
    t.string   "name",               limit: 80
    t.boolean  "isdeleted"
    t.datetime "lastmodifieddate"
    t.datetime "systemmodstamp"
    t.datetime "createddate"
    t.text     "_hc_err"
    t.string   "sfid",               limit: 18
    t.string   "_hc_lastop",         limit: 32
    t.float    "i_m__externalid__c"
  end

  add_index "i_m__request_bom__c", ["i_m__externalid__c"], name: "hcu_idx_i_m__request_bom__c_i_m__externalid__c", unique: true, using: :btree
  add_index "i_m__request_bom__c", ["lastmodifieddate"], name: "hc_idx_i_m__request_bom__c_lastmodifieddate", using: :btree
  add_index "i_m__request_bom__c", ["sfid"], name: "hcu_idx_i_m__request_bom__c_sfid", unique: true, using: :btree
  add_index "i_m__request_bom__c", ["systemmodstamp"], name: "hc_idx_i_m__request_bom__c_systemmodstamp", using: :btree

  create_table "i_m__request_entity__c", force: :cascade do |t|
    t.string   "sfid",                                       limit: 18
    t.string   "i_m__to_item__c",                            limit: 18
    t.string   "_hc_lastop",                                 limit: 32
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.text     "_hc_err"
    t.string   "i_m__to_request_bom__c",                     limit: 18
    t.float    "i_m__amount__c"
    t.datetime "createddate"
    t.string   "name",                                       limit: 80
    t.float    "i_m__to_request_bom__r__i_m__externalid__c"
  end

  add_index "i_m__request_entity__c", ["i_m__to_request_bom__c"], name: "hc_idx_i_m__request_entity__c_i_m__to_request_bom__c", using: :btree
  add_index "i_m__request_entity__c", ["i_m__to_request_bom__r__i_m__externalid__c"], name: "hc_idx_i_m__request_entity__c_i_m__to_request_bom__r__i_a84c", using: :btree
  add_index "i_m__request_entity__c", ["sfid"], name: "hcu_idx_i_m__request_entity__c_sfid", unique: true, using: :btree
  add_index "i_m__request_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__request_entity__c_systemmodstamp", using: :btree

  create_table "i_m__show_and_event__c", force: :cascade do |t|
    t.string   "_hc_lastop",                limit: 32
    t.date     "lastactivitydate"
    t.string   "lastmodifiedbyid",          limit: 18
    t.date     "i_m__end_date__c"
    t.datetime "createddate"
    t.string   "name",                      limit: 80
    t.string   "i_m__city__c",              limit: 255
    t.datetime "systemmodstamp"
    t.string   "i_m__convention_center__c", limit: 18
    t.boolean  "isdeleted"
    t.date     "i_m__start_date__c"
    t.string   "sfid",                      limit: 18
    t.text     "_hc_err"
  end

  add_index "i_m__show_and_event__c", ["sfid"], name: "hcu_idx_i_m__show_and_event__c_sfid", unique: true, using: :btree
  add_index "i_m__show_and_event__c", ["systemmodstamp"], name: "hc_idx_i_m__show_and_event__c_systemmodstamp", using: :btree

  create_table "i_m__stock_item__c", force: :cascade do |t|
    t.boolean  "isdeleted"
    t.datetime "systemmodstamp"
    t.float    "i_m__amount__c"
    t.datetime "createddate"
    t.string   "sfid",               limit: 18
    t.string   "_hc_lastop",         limit: 32
    t.string   "i_m__to_account__c", limit: 18
    t.text     "_hc_err"
    t.string   "name",               limit: 80
    t.string   "i_m__location__c",   limit: 120
    t.string   "i_m__to_item__c",    limit: 18
  end

  add_index "i_m__stock_item__c", ["sfid"], name: "hcu_idx_i_m__stock_item__c_sfid", unique: true, using: :btree
  add_index "i_m__stock_item__c", ["systemmodstamp"], name: "hc_idx_i_m__stock_item__c_systemmodstamp", using: :btree

  create_table "recordtype", force: :cascade do |t|
    t.datetime "systemmodstamp"
    t.string   "name",           limit: 80
    t.datetime "createddate"
    t.string   "sfid",           limit: 18
    t.text     "_hc_err"
    t.string   "_hc_lastop",     limit: 32
  end

  add_index "recordtype", ["sfid"], name: "hcu_idx_recordtype_sfid", unique: true, using: :btree
  add_index "recordtype", ["systemmodstamp"], name: "hc_idx_recordtype_systemmodstamp", using: :btree

end
