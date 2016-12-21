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

  create_table "salesforce.account", force: :cascade do |t|
    t.string   "_hc_lastop",                   limit: 32
    t.string   "i_m__suggested_renatl_set__c", limit: 18
    t.string   "name",                         limit: 255
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.datetime "createddate"
    t.string   "sfid",                         limit: 18
    t.text     "_hc_err"
    t.string   "masterrecordid",               limit: 18
    t.string   "recordtypeid",                 limit: 18
  end

  add_index "salesforce.account", ["i_m__suggested_renatl_set__c"], name: "hc_idx_account_i_m__suggested_renatl_set__c", using: :btree
  add_index "salesforce.account", ["masterrecordid"], name: "hc_idx_account_masterrecordid", using: :btree
  add_index "salesforce.account", ["recordtypeid"], name: "hc_idx_account_recordtypeid", using: :btree
  add_index "salesforce.account", ["sfid"], name: "hcu_idx_account_sfid", unique: true, using: :btree
  add_index "salesforce.account", ["systemmodstamp"], name: "hc_idx_account_systemmodstamp", using: :btree

  create_table "salesforce.i_m__bom__c", force: :cascade do |t|
    t.text     "_hc_err"
    t.string   "name",           limit: 80
    t.string   "sfid",           limit: 18
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.string   "_hc_lastop",     limit: 32
    t.boolean  "isdeleted"
  end

  add_index "salesforce.i_m__bom__c", ["sfid"], name: "hcu_idx_i_m__bom__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__bom__c", ["systemmodstamp"], name: "hc_idx_i_m__bom__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__category__c", force: :cascade do |t|
    t.string   "_hc_lastop",         limit: 32
    t.string   "sfid",               limit: 18
    t.datetime "createddate"
    t.boolean  "isdeleted"
    t.text     "_hc_err"
    t.float    "i_m__externalid__c"
    t.string   "name",               limit: 80
    t.datetime "systemmodstamp"
  end

  add_index "salesforce.i_m__category__c", ["i_m__externalid__c"], name: "hcu_idx_i_m__category__c_i_m__externalid__c", unique: true, using: :btree
  add_index "salesforce.i_m__category__c", ["sfid"], name: "hcu_idx_i_m__category__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__category__c", ["systemmodstamp"], name: "hc_idx_i_m__category__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__category_entity__c", force: :cascade do |t|
    t.string   "i_m__to_category__c",     limit: 18
    t.text     "_hc_err"
    t.string   "name",                    limit: 80
    t.string   "i_m__to_category_set__c", limit: 18
    t.string   "_hc_lastop",              limit: 32
    t.datetime "createddate"
    t.string   "sfid",                    limit: 18
    t.boolean  "isdeleted"
    t.datetime "systemmodstamp"
    t.string   "i_m__to_default__c",      limit: 18
  end

  add_index "salesforce.i_m__category_entity__c", ["i_m__to_category__c"], name: "hc_idx_i_m__category_entity__c_i_m__to_category__c", using: :btree
  add_index "salesforce.i_m__category_entity__c", ["i_m__to_category_set__c"], name: "hc_idx_i_m__category_entity__c_i_m__to_category_set__c", using: :btree
  add_index "salesforce.i_m__category_entity__c", ["i_m__to_default__c"], name: "hc_idx_i_m__category_entity__c_i_m__to_default__c", using: :btree
  add_index "salesforce.i_m__category_entity__c", ["sfid"], name: "hcu_idx_i_m__category_entity__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__category_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__category_entity__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__category_set__c", force: :cascade do |t|
    t.boolean  "isdeleted"
    t.datetime "createddate"
    t.string   "_hc_lastop",     limit: 32
    t.string   "sfid",           limit: 18
    t.text     "_hc_err"
    t.datetime "systemmodstamp"
    t.string   "name",           limit: 80
  end

  add_index "salesforce.i_m__category_set__c", ["sfid"], name: "hcu_idx_i_m__category_set__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__category_set__c", ["systemmodstamp"], name: "hc_idx_i_m__category_set__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__configuration__c", force: :cascade do |t|
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
    t.string   "i_m__photo__c",           limit: 100
  end

  add_index "salesforce.i_m__configuration__c", ["i_m__to_account__c"], name: "hc_idx_i_m__configuration__c_i_m__to_account__c", using: :btree
  add_index "salesforce.i_m__configuration__c", ["i_m__to_bom__c"], name: "hc_idx_i_m__configuration__c_i_m__to_bom__c", using: :btree
  add_index "salesforce.i_m__configuration__c", ["i_m__to_category_set__c"], name: "hc_idx_i_m__configuration__c_i_m__to_category_set__c", using: :btree
  add_index "salesforce.i_m__configuration__c", ["sfid"], name: "hcu_idx_i_m__configuration__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__configuration__c", ["systemmodstamp"], name: "hc_idx_i_m__configuration__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__graphic_entity__c", force: :cascade do |t|
    t.datetime "createddate"
    t.string   "sfid",                    limit: 18
    t.string   "name",                    limit: 80
    t.text     "_hc_err"
    t.boolean  "isdeleted"
    t.string   "_hc_lastop",              limit: 32
    t.datetime "systemmodstamp"
    t.string   "i_m__to_graphics_set__c", limit: 18
    t.string   "i_m__to_item__c",         limit: 18
    t.string   "i_m__position__c",        limit: 10
  end

  add_index "salesforce.i_m__graphic_entity__c", ["sfid"], name: "hcu_idx_i_m__graphic_entity__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__graphic_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__graphic_entity__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__graphics_set__c", force: :cascade do |t|
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.string   "name",                     limit: 80
    t.string   "sfid",                     limit: 18
    t.string   "_hc_lastop",               limit: 32
    t.string   "i_m__to_configuration__c", limit: 18
    t.text     "_hc_err"
    t.boolean  "isdeleted"
  end

  add_index "salesforce.i_m__graphics_set__c", ["sfid"], name: "hcu_idx_i_m__graphics_set__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__graphics_set__c", ["systemmodstamp"], name: "hc_idx_i_m__graphics_set__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__item__c", force: :cascade do |t|
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

  add_index "salesforce.i_m__item__c", ["i_m__category__c__i_m__externalid__c"], name: "hc_idx_i_m__item__c_i_m__category__c__i_m__externalid__c", using: :btree
  add_index "salesforce.i_m__item__c", ["i_m__to_category__c"], name: "hc_idx_i_m__item__c_i_m__to_category__c", using: :btree
  add_index "salesforce.i_m__item__c", ["sfid"], name: "hcu_idx_i_m__item__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__item__c", ["systemmodstamp"], name: "hc_idx_i_m__item__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__item_entity__c", force: :cascade do |t|
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

  add_index "salesforce.i_m__item_entity__c", ["i_m__to_bom__c"], name: "hc_idx_i_m__item_entity__c_i_m__to_bom__c", using: :btree
  add_index "salesforce.i_m__item_entity__c", ["i_m__to_item__c"], name: "hc_idx_i_m__item_entity__c_i_m__to_item__c", using: :btree
  add_index "salesforce.i_m__item_entity__c", ["sfid"], name: "hcu_idx_i_m__item_entity__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__item_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__item_entity__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__load_entity__c", force: :cascade do |t|
    t.string   "i_m__to_item__c",             limit: 18
    t.datetime "createddate"
    t.string   "i_m__to_storage_location__c", limit: 18
    t.datetime "systemmodstamp"
    t.string   "name",                        limit: 80
    t.string   "sfid",                        limit: 18
    t.string   "_hc_lastop",                  limit: 32
    t.float    "i_m__amount__c"
    t.string   "i_m__to_current_location__c", limit: 18
    t.text     "_hc_err"
    t.boolean  "isdeleted"
    t.string   "i_m__to_load_list__c",        limit: 18
  end

  add_index "salesforce.i_m__load_entity__c", ["i_m__amount__c"], name: "hc_idx_i_m__load_entity__c_i_m__amount__c", using: :btree
  add_index "salesforce.i_m__load_entity__c", ["i_m__to_current_location__c"], name: "hc_idx_i_m__load_entity__c_i_m__to_current_location__c", using: :btree
  add_index "salesforce.i_m__load_entity__c", ["i_m__to_item__c"], name: "hc_idx_i_m__load_entity__c_i_m__to_item__c", using: :btree
  add_index "salesforce.i_m__load_entity__c", ["i_m__to_load_list__c"], name: "hc_idx_i_m__load_entity__c_i_m__to_load_list__c", using: :btree
  add_index "salesforce.i_m__load_entity__c", ["i_m__to_storage_location__c"], name: "hc_idx_i_m__load_entity__c_i_m__to_storage_location__c", using: :btree
  add_index "salesforce.i_m__load_entity__c", ["sfid"], name: "hcu_idx_i_m__load_entity__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__load_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__load_entity__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__load_list__c", force: :cascade do |t|
    t.string   "_hc_lastop",     limit: 32
    t.datetime "createddate"
    t.string   "name",           limit: 80
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.string   "sfid",           limit: 18
    t.text     "_hc_err"
  end

  add_index "salesforce.i_m__load_list__c", ["sfid"], name: "hcu_idx_i_m__load_list__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__load_list__c", ["systemmodstamp"], name: "hc_idx_i_m__load_list__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__load_order__c", force: :cascade do |t|
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.string   "name",                 limit: 80
    t.string   "sfid",                 limit: 18
    t.text     "_hc_err"
    t.string   "_hc_lastop",           limit: 32
    t.boolean  "isdeleted"
    t.string   "i_m__to_load_list__c", limit: 18
  end

  add_index "salesforce.i_m__load_order__c", ["i_m__to_load_list__c"], name: "hc_idx_i_m__load_order__c_i_m__to_load_list__c", using: :btree
  add_index "salesforce.i_m__load_order__c", ["sfid"], name: "hcu_idx_i_m__load_order__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__load_order__c", ["systemmodstamp"], name: "hc_idx_i_m__load_order__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__order_request__c", force: :cascade do |t|
    t.text     "_hc_err"
    t.string   "i_m__to_event__c",                           limit: 18
    t.string   "name",                                       limit: 80
    t.string   "sfid",                                       limit: 18
    t.string   "i_m__to_account__c",                         limit: 18
    t.boolean  "isdeleted"
    t.datetime "systemmodstamp"
    t.datetime "createddate"
    t.string   "i_m__to_request_bom__r__i_m__externalid__c", limit: 10
    t.string   "i_m__to_request_bom__c",                     limit: 18
    t.string   "_hc_lastop",                                 limit: 32
    t.string   "i_m__to_configuration__c",                   limit: 18
    t.string   "i_m__status__c",                             limit: 255
    t.string   "i_m__to_opportunity__c",                     limit: 18
  end

  add_index "salesforce.i_m__order_request__c", ["i_m__to_account__c"], name: "hc_idx_i_m__order_request__c_i_m__to_account__c", using: :btree
  add_index "salesforce.i_m__order_request__c", ["i_m__to_configuration__c"], name: "hc_idx_i_m__order_request__c_i_m__to_configuration__c", using: :btree
  add_index "salesforce.i_m__order_request__c", ["i_m__to_event__c"], name: "hc_idx_i_m__order_request__c_i_m__to_event__c", using: :btree
  add_index "salesforce.i_m__order_request__c", ["i_m__to_request_bom__c"], name: "hc_idx_i_m__order_request__c_i_m__to_request_bom__c", using: :btree
  add_index "salesforce.i_m__order_request__c", ["sfid"], name: "hcu_idx_i_m__order_request__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__order_request__c", ["systemmodstamp"], name: "hc_idx_i_m__order_request__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__rental_provider__c", force: :cascade do |t|
    t.boolean  "isdeleted"
    t.text     "_hc_err"
    t.string   "_hc_lastop",      limit: 32
    t.string   "sfid",            limit: 18
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.string   "i_m__account__c", limit: 18
    t.string   "name",            limit: 80
  end

  add_index "salesforce.i_m__rental_provider__c", ["i_m__account__c"], name: "hc_idx_i_m__rental_provider__c_i_m__account__c", using: :btree
  add_index "salesforce.i_m__rental_provider__c", ["sfid"], name: "hcu_idx_i_m__rental_provider__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__rental_provider__c", ["systemmodstamp"], name: "hc_idx_i_m__rental_provider__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__request_bom__c", force: :cascade do |t|
    t.string   "sfid",               limit: 18
    t.text     "_hc_err"
    t.string   "_hc_lastop",         limit: 32
    t.string   "i_m__externalid__c", limit: 10
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.string   "name",               limit: 80
  end

  add_index "salesforce.i_m__request_bom__c", ["i_m__externalid__c"], name: "hcu_idx_i_m__request_bom__c_i_m__externalid__c", unique: true, using: :btree
  add_index "salesforce.i_m__request_bom__c", ["sfid"], name: "hcu_idx_i_m__request_bom__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__request_bom__c", ["systemmodstamp"], name: "hc_idx_i_m__request_bom__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__request_entity__c", force: :cascade do |t|
    t.float    "i_m__amount__c"
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.string   "i_m__to_item__c",                            limit: 18
    t.boolean  "isdeleted"
    t.string   "sfid",                                       limit: 18
    t.string   "i_m__to_request_bom__r__i_m__externalid__c", limit: 10
    t.string   "_hc_lastop",                                 limit: 32
    t.string   "name",                                       limit: 80
    t.string   "i_m__to_request_bom__c",                     limit: 18
    t.text     "_hc_err"
    t.string   "i_m__provider__c",                           limit: 20
  end

  add_index "salesforce.i_m__request_entity__c", ["i_m__to_item__c"], name: "hc_idx_i_m__request_entity__c_i_m__to_item__c", using: :btree
  add_index "salesforce.i_m__request_entity__c", ["i_m__to_request_bom__c"], name: "hc_idx_i_m__request_entity__c_i_m__to_request_bom__c", using: :btree
  add_index "salesforce.i_m__request_entity__c", ["i_m__to_request_bom__r__i_m__externalid__c"], name: "hc_idx_i_m__request_entity__c_i_m__to_request_bom__r__i_a84c", using: :btree
  add_index "salesforce.i_m__request_entity__c", ["sfid"], name: "hcu_idx_i_m__request_entity__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__request_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__request_entity__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__show_and_event__c", force: :cascade do |t|
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

  add_index "salesforce.i_m__show_and_event__c", ["i_m__convention_center__c"], name: "hc_idx_i_m__show_and_event__c_i_m__convention_center__c", using: :btree
  add_index "salesforce.i_m__show_and_event__c", ["sfid"], name: "hcu_idx_i_m__show_and_event__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__show_and_event__c", ["systemmodstamp"], name: "hc_idx_i_m__show_and_event__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__stock_item__c", force: :cascade do |t|
    t.string   "i_m__to_storage_location__c", limit: 18
    t.string   "name",                        limit: 80
    t.string   "_hc_lastop",                  limit: 32
    t.float    "i_m__amount__c"
    t.boolean  "isdeleted"
    t.string   "i_m__to_item__c",             limit: 18
    t.datetime "systemmodstamp"
    t.string   "i_m__to_account__c",          limit: 18
    t.string   "sfid",                        limit: 18
    t.datetime "createddate"
    t.text     "_hc_err"
  end

  add_index "salesforce.i_m__stock_item__c", ["i_m__to_account__c"], name: "hc_idx_i_m__stock_item__c_i_m__to_account__c", using: :btree
  add_index "salesforce.i_m__stock_item__c", ["i_m__to_item__c"], name: "hc_idx_i_m__stock_item__c_i_m__to_item__c", using: :btree
  add_index "salesforce.i_m__stock_item__c", ["i_m__to_storage_location__c"], name: "hc_idx_i_m__stock_item__c_i_m__to_storage_location__c", using: :btree
  add_index "salesforce.i_m__stock_item__c", ["sfid"], name: "hcu_idx_i_m__stock_item__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__stock_item__c", ["systemmodstamp"], name: "hc_idx_i_m__stock_item__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__storage_location__c", force: :cascade do |t|
    t.string   "_hc_lastop",     limit: 32
    t.datetime "createddate"
    t.string   "name",           limit: 80
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.string   "sfid",           limit: 18
    t.text     "_hc_err"
  end

  add_index "salesforce.i_m__storage_location__c", ["sfid"], name: "hcu_idx_i_m__storage_location__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__storage_location__c", ["systemmodstamp"], name: "hc_idx_i_m__storage_location__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__suggested_rental_entity__c", force: :cascade do |t|
    t.string   "name",                            limit: 80
    t.string   "sfid",                            limit: 18
    t.string   "i_m__to_item__c",                 limit: 18
    t.datetime "createddate"
    t.string   "i_m__to_suggested_rental_set__c", limit: 18
    t.datetime "systemmodstamp"
    t.text     "_hc_err"
    t.string   "_hc_lastop",                      limit: 32
    t.boolean  "isdeleted"
  end

  add_index "salesforce.i_m__suggested_rental_entity__c", ["i_m__to_item__c"], name: "hc_idx_i_m__suggested_rental_entity__c_i_m__to_item__c", using: :btree
  add_index "salesforce.i_m__suggested_rental_entity__c", ["i_m__to_suggested_rental_set__c"], name: "hc_idx_i_m__suggested_rental_entity__c_i_m__to_suggeste_fae1", using: :btree
  add_index "salesforce.i_m__suggested_rental_entity__c", ["sfid"], name: "hcu_idx_i_m__suggested_rental_entity__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__suggested_rental_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__suggested_rental_entity__c_systemmodstamp", using: :btree

  create_table "salesforce.i_m__suggested_rental_set__c", force: :cascade do |t|
    t.string   "_hc_lastop",     limit: 32
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.string   "sfid",           limit: 18
    t.string   "name",           limit: 80
    t.datetime "createddate"
    t.text     "_hc_err"
  end

  add_index "salesforce.i_m__suggested_rental_set__c", ["sfid"], name: "hcu_idx_i_m__suggested_rental_set__c_sfid", unique: true, using: :btree
  add_index "salesforce.i_m__suggested_rental_set__c", ["systemmodstamp"], name: "hc_idx_i_m__suggested_rental_set__c_systemmodstamp", using: :btree

  create_table "salesforce.opportunity", force: :cascade do |t|
    t.string   "accountid",                              limit: 18
    t.string   "_hc_lastop",                             limit: 32
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.date     "i_m__golden_targeted_shipping_date__c"
    t.string   "name",                                   limit: 120
    t.text     "_hc_err"
    t.date     "i_m__golden_anticipated_return_date__c"
    t.boolean  "isdeleted"
    t.float    "amount"
    t.string   "sfid",                                   limit: 18
  end

  add_index "salesforce.opportunity", ["sfid"], name: "hcu_idx_opportunity_sfid", unique: true, using: :btree
  add_index "salesforce.opportunity", ["systemmodstamp"], name: "hc_idx_opportunity_systemmodstamp", using: :btree

  create_table "salesforce.order", force: :cascade do |t|
    t.boolean  "isdeleted"
    t.string   "accountid",                   limit: 18
    t.string   "i_m__related_opportunity__c", limit: 18
    t.string   "_hc_lastop",                  limit: 32
    t.text     "_hc_err"
    t.string   "sfid",                        limit: 18
    t.datetime "systemmodstamp"
    t.datetime "createddate"
    t.string   "name",                        limit: 80
  end

  add_index "salesforce.order", ["sfid"], name: "hcu_idx_order_sfid", unique: true, using: :btree
  add_index "salesforce.order", ["systemmodstamp"], name: "hc_idx_order_systemmodstamp", using: :btree

  create_table "salesforce.recordtype", force: :cascade do |t|
    t.datetime "systemmodstamp"
    t.string   "name",           limit: 80
    t.datetime "createddate"
    t.string   "sfid",           limit: 18
    t.text     "_hc_err"
    t.string   "_hc_lastop",     limit: 32
  end

  add_index "salesforce.recordtype", ["sfid"], name: "hcu_idx_recordtype_sfid", unique: true, using: :btree
  add_index "salesforce.recordtype", ["systemmodstamp"], name: "hc_idx_recordtype_systemmodstamp", using: :btree

end
