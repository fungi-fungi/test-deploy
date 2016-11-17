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

  create_table "_sf_event_log", force: :cascade do |t|
    t.string   "table_name",   limit: 128
    t.string   "action",       limit: 7
    t.datetime "synced_at",                default: "now()"
    t.datetime "sf_timestamp"
    t.string   "sfid",         limit: 20
    t.text     "record"
    t.boolean  "processed"
  end

  add_index "_sf_event_log", ["sfid"], name: "idx__sf_event_log_sfid", using: :btree
  add_index "_sf_event_log", ["table_name", "synced_at"], name: "idx__sf_event_log_comp_key", using: :btree

  create_table "_trigger_last_id", id: false, force: :cascade do |t|
    t.integer "trigger_log_id"
  end

  create_table "_trigger_log", force: :cascade do |t|
    t.text     "old"
    t.string   "table_name",   limit: 128
    t.integer  "record_id"
    t.integer  "sf_result"
    t.datetime "updated_at",               default: "now()"
    t.integer  "txid",         limit: 8
    t.datetime "created_at",               default: "now()"
    t.integer  "processed_tx", limit: 8
    t.text     "values"
    t.datetime "processed_at"
    t.string   "state",        limit: 8
    t.text     "sf_message"
    t.string   "sfid",         limit: 18
    t.string   "action",       limit: 7
  end

  add_index "_trigger_log", ["created_at"], name: "_trigger_log_idx_created_at", using: :btree
  add_index "_trigger_log", ["state", "id"], name: "_trigger_log_idx_state_id", using: :btree
  add_index "_trigger_log", ["state", "table_name"], name: "_trigger_log_idx_state_table_name", where: "(((state)::text = 'NEW'::text) OR ((state)::text = 'PENDING'::text))", using: :btree

  create_table "_trigger_log_archive", force: :cascade do |t|
    t.text     "old"
    t.string   "table_name",   limit: 128
    t.integer  "record_id"
    t.integer  "sf_result"
    t.datetime "updated_at"
    t.integer  "txid",         limit: 8
    t.datetime "created_at"
    t.integer  "processed_tx", limit: 8
    t.text     "values"
    t.datetime "processed_at"
    t.string   "state",        limit: 8
    t.text     "sf_message"
    t.string   "sfid",         limit: 18
    t.string   "action",       limit: 7
  end

  add_index "_trigger_log_archive", ["created_at"], name: "_trigger_log_archive_idx_created_at", using: :btree
  add_index "_trigger_log_archive", ["record_id"], name: "_trigger_log_archive_idx_record_id", using: :btree
  add_index "_trigger_log_archive", ["state", "table_name"], name: "_trigger_log_archive_idx_state_table_name", where: "((state)::text = 'FAILED'::text)", using: :btree

  create_table "account", force: :cascade do |t|
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

  add_index "account", ["i_m__suggested_renatl_set__c"], name: "hc_idx_account_i_m__suggested_renatl_set__c", using: :btree
  add_index "account", ["masterrecordid"], name: "hc_idx_account_masterrecordid", using: :btree
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
    t.string   "i_m__to_default__c",      limit: 18
  end

  add_index "i_m__category_entity__c", ["i_m__to_category__c"], name: "hc_idx_i_m__category_entity__c_i_m__to_category__c", using: :btree
  add_index "i_m__category_entity__c", ["i_m__to_category_set__c"], name: "hc_idx_i_m__category_entity__c_i_m__to_category_set__c", using: :btree
  add_index "i_m__category_entity__c", ["i_m__to_default__c"], name: "hc_idx_i_m__category_entity__c_i_m__to_default__c", using: :btree
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
    t.string   "i_m__photo__c",           limit: 100
  end

  add_index "i_m__configuration__c", ["i_m__to_account__c"], name: "hc_idx_i_m__configuration__c_i_m__to_account__c", using: :btree
  add_index "i_m__configuration__c", ["i_m__to_bom__c"], name: "hc_idx_i_m__configuration__c_i_m__to_bom__c", using: :btree
  add_index "i_m__configuration__c", ["i_m__to_category_set__c"], name: "hc_idx_i_m__configuration__c_i_m__to_category_set__c", using: :btree
  add_index "i_m__configuration__c", ["sfid"], name: "hcu_idx_i_m__configuration__c_sfid", unique: true, using: :btree
  add_index "i_m__configuration__c", ["systemmodstamp"], name: "hc_idx_i_m__configuration__c_systemmodstamp", using: :btree

  create_table "i_m__graphic_entity__c", force: :cascade do |t|
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

  add_index "i_m__graphic_entity__c", ["sfid"], name: "hcu_idx_i_m__graphic_entity__c_sfid", unique: true, using: :btree
  add_index "i_m__graphic_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__graphic_entity__c_systemmodstamp", using: :btree

  create_table "i_m__graphics_set__c", force: :cascade do |t|
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.string   "name",                     limit: 80
    t.string   "sfid",                     limit: 18
    t.string   "_hc_lastop",               limit: 32
    t.string   "i_m__to_configuration__c", limit: 18
    t.text     "_hc_err"
    t.boolean  "isdeleted"
  end

  add_index "i_m__graphics_set__c", ["sfid"], name: "hcu_idx_i_m__graphics_set__c_sfid", unique: true, using: :btree
  add_index "i_m__graphics_set__c", ["systemmodstamp"], name: "hc_idx_i_m__graphics_set__c_systemmodstamp", using: :btree

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

  create_table "i_m__load_entity__c", force: :cascade do |t|
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

  add_index "i_m__load_entity__c", ["i_m__amount__c"], name: "hc_idx_i_m__load_entity__c_i_m__amount__c", using: :btree
  add_index "i_m__load_entity__c", ["i_m__to_current_location__c"], name: "hc_idx_i_m__load_entity__c_i_m__to_current_location__c", using: :btree
  add_index "i_m__load_entity__c", ["i_m__to_item__c"], name: "hc_idx_i_m__load_entity__c_i_m__to_item__c", using: :btree
  add_index "i_m__load_entity__c", ["i_m__to_load_list__c"], name: "hc_idx_i_m__load_entity__c_i_m__to_load_list__c", using: :btree
  add_index "i_m__load_entity__c", ["i_m__to_storage_location__c"], name: "hc_idx_i_m__load_entity__c_i_m__to_storage_location__c", using: :btree
  add_index "i_m__load_entity__c", ["sfid"], name: "hcu_idx_i_m__load_entity__c_sfid", unique: true, using: :btree
  add_index "i_m__load_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__load_entity__c_systemmodstamp", using: :btree

  create_table "i_m__load_list__c", force: :cascade do |t|
    t.string   "_hc_lastop",     limit: 32
    t.datetime "createddate"
    t.string   "name",           limit: 80
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.string   "sfid",           limit: 18
    t.text     "_hc_err"
  end

  add_index "i_m__load_list__c", ["sfid"], name: "hcu_idx_i_m__load_list__c_sfid", unique: true, using: :btree
  add_index "i_m__load_list__c", ["systemmodstamp"], name: "hc_idx_i_m__load_list__c_systemmodstamp", using: :btree

  create_table "i_m__load_order__c", force: :cascade do |t|
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.string   "name",                 limit: 80
    t.string   "sfid",                 limit: 18
    t.text     "_hc_err"
    t.string   "_hc_lastop",           limit: 32
    t.boolean  "isdeleted"
    t.string   "i_m__to_load_list__c", limit: 18
  end

  add_index "i_m__load_order__c", ["i_m__to_load_list__c"], name: "hc_idx_i_m__load_order__c_i_m__to_load_list__c", using: :btree
  add_index "i_m__load_order__c", ["sfid"], name: "hcu_idx_i_m__load_order__c_sfid", unique: true, using: :btree
  add_index "i_m__load_order__c", ["systemmodstamp"], name: "hc_idx_i_m__load_order__c_systemmodstamp", using: :btree

  create_table "i_m__order_request__c", force: :cascade do |t|
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
  end

  add_index "i_m__order_request__c", ["i_m__to_account__c"], name: "hc_idx_i_m__order_request__c_i_m__to_account__c", using: :btree
  add_index "i_m__order_request__c", ["i_m__to_event__c"], name: "hc_idx_i_m__order_request__c_i_m__to_event__c", using: :btree
  add_index "i_m__order_request__c", ["i_m__to_request_bom__c"], name: "hc_idx_i_m__order_request__c_i_m__to_request_bom__c", using: :btree
  add_index "i_m__order_request__c", ["sfid"], name: "hcu_idx_i_m__order_request__c_sfid", unique: true, using: :btree
  add_index "i_m__order_request__c", ["systemmodstamp"], name: "hc_idx_i_m__order_request__c_systemmodstamp", using: :btree

  create_table "i_m__rental_provider__c", force: :cascade do |t|
    t.boolean  "isdeleted"
    t.text     "_hc_err"
    t.string   "_hc_lastop",      limit: 32
    t.string   "sfid",            limit: 18
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.string   "i_m__account__c", limit: 18
    t.string   "name",            limit: 80
  end

  add_index "i_m__rental_provider__c", ["i_m__account__c"], name: "hc_idx_i_m__rental_provider__c_i_m__account__c", using: :btree
  add_index "i_m__rental_provider__c", ["sfid"], name: "hcu_idx_i_m__rental_provider__c_sfid", unique: true, using: :btree
  add_index "i_m__rental_provider__c", ["systemmodstamp"], name: "hc_idx_i_m__rental_provider__c_systemmodstamp", using: :btree

  create_table "i_m__request_bom__c", force: :cascade do |t|
    t.string   "sfid",               limit: 18
    t.text     "_hc_err"
    t.string   "_hc_lastop",         limit: 32
    t.string   "i_m__externalid__c", limit: 10
    t.datetime "createddate"
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.string   "name",               limit: 80
  end

  add_index "i_m__request_bom__c", ["i_m__externalid__c"], name: "hcu_idx_i_m__request_bom__c_i_m__externalid__c", unique: true, using: :btree
  add_index "i_m__request_bom__c", ["sfid"], name: "hcu_idx_i_m__request_bom__c_sfid", unique: true, using: :btree
  add_index "i_m__request_bom__c", ["systemmodstamp"], name: "hc_idx_i_m__request_bom__c_systemmodstamp", using: :btree

  create_table "i_m__request_entity__c", force: :cascade do |t|
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

  add_index "i_m__request_entity__c", ["i_m__to_item__c"], name: "hc_idx_i_m__request_entity__c_i_m__to_item__c", using: :btree
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

  add_index "i_m__show_and_event__c", ["i_m__convention_center__c"], name: "hc_idx_i_m__show_and_event__c_i_m__convention_center__c", using: :btree
  add_index "i_m__show_and_event__c", ["sfid"], name: "hcu_idx_i_m__show_and_event__c_sfid", unique: true, using: :btree
  add_index "i_m__show_and_event__c", ["systemmodstamp"], name: "hc_idx_i_m__show_and_event__c_systemmodstamp", using: :btree

  create_table "i_m__stock_item__c", force: :cascade do |t|
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

  add_index "i_m__stock_item__c", ["i_m__to_account__c"], name: "hc_idx_i_m__stock_item__c_i_m__to_account__c", using: :btree
  add_index "i_m__stock_item__c", ["i_m__to_item__c"], name: "hc_idx_i_m__stock_item__c_i_m__to_item__c", using: :btree
  add_index "i_m__stock_item__c", ["i_m__to_storage_location__c"], name: "hc_idx_i_m__stock_item__c_i_m__to_storage_location__c", using: :btree
  add_index "i_m__stock_item__c", ["sfid"], name: "hcu_idx_i_m__stock_item__c_sfid", unique: true, using: :btree
  add_index "i_m__stock_item__c", ["systemmodstamp"], name: "hc_idx_i_m__stock_item__c_systemmodstamp", using: :btree

  create_table "i_m__storage_location__c", force: :cascade do |t|
    t.string   "_hc_lastop",     limit: 32
    t.datetime "createddate"
    t.string   "name",           limit: 80
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.string   "sfid",           limit: 18
    t.text     "_hc_err"
  end

  add_index "i_m__storage_location__c", ["sfid"], name: "hcu_idx_i_m__storage_location__c_sfid", unique: true, using: :btree
  add_index "i_m__storage_location__c", ["systemmodstamp"], name: "hc_idx_i_m__storage_location__c_systemmodstamp", using: :btree

  create_table "i_m__suggested_rental_entity__c", force: :cascade do |t|
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

  add_index "i_m__suggested_rental_entity__c", ["i_m__to_item__c"], name: "hc_idx_i_m__suggested_rental_entity__c_i_m__to_item__c", using: :btree
  add_index "i_m__suggested_rental_entity__c", ["i_m__to_suggested_rental_set__c"], name: "hc_idx_i_m__suggested_rental_entity__c_i_m__to_suggeste_fae1", using: :btree
  add_index "i_m__suggested_rental_entity__c", ["sfid"], name: "hcu_idx_i_m__suggested_rental_entity__c_sfid", unique: true, using: :btree
  add_index "i_m__suggested_rental_entity__c", ["systemmodstamp"], name: "hc_idx_i_m__suggested_rental_entity__c_systemmodstamp", using: :btree

  create_table "i_m__suggested_rental_set__c", force: :cascade do |t|
    t.string   "_hc_lastop",     limit: 32
    t.datetime "systemmodstamp"
    t.boolean  "isdeleted"
    t.string   "sfid",           limit: 18
    t.string   "name",           limit: 80
    t.datetime "createddate"
    t.text     "_hc_err"
  end

  add_index "i_m__suggested_rental_set__c", ["sfid"], name: "hcu_idx_i_m__suggested_rental_set__c_sfid", unique: true, using: :btree
  add_index "i_m__suggested_rental_set__c", ["systemmodstamp"], name: "hc_idx_i_m__suggested_rental_set__c_systemmodstamp", using: :btree

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
