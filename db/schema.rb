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

ActiveRecord::Schema[8.0].define(version: 2024_12_31_084846) do
  create_schema "pgroonga"

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgroonga"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "allowed_sources", force: :cascade do |t|
    t.string "namespace", null: false
    t.integer "octet1", null: false
    t.integer "octet2", null: false
    t.integer "octet3", null: false
    t.integer "octet4", null: false
    t.boolean "wildcard", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["namespace", "octet1", "octet2", "octet3", "octet4"], name: "index_allowed_sources_on_namespace_add_octets", unique: true
  end

  create_table "blog_comments", force: :cascade do |t|
    t.text "review"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.date "days"
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "video"
    t.string "image"
    t.string "file"
    t.boolean "status", default: false, null: false
    t.boolean "switch", default: false, null: false
    t.integer "user_id", default: 0, null: false
    t.index ["body"], name: "index_blogs_on_body", using: :pgroonga
    t.index ["title"], name: "index_blogs_on_title", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body"], name: "index_comments_on_body", using: :pgroonga
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

# Could not dump table "pg_aggregate" because of following StandardError
#   Unknown type 'regproc' for column 'aggfnoid'


# Could not dump table "pg_am" because of following StandardError
#   Unknown type 'regproc' for column 'amhandler'


  create_table "pg_amop", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.oid "amopfamily", null: false
    t.oid "amoplefttype", null: false
    t.oid "amoprighttype", null: false
    t.integer "amopstrategy", limit: 2, null: false
    t.string "amoppurpose", null: false
    t.oid "amopopr", null: false
    t.oid "amopmethod", null: false
    t.oid "amopsortfamily", null: false

    t.unique_constraint ["amopfamily", "amoplefttype", "amoprighttype", "amopstrategy"], name: "pg_amop_fam_strat_index"
    t.unique_constraint ["amopopr", "amoppurpose", "amopfamily"], name: "pg_amop_opr_fam_index"
  end

# Could not dump table "pg_amproc" because of following StandardError
#   Unknown type 'regproc' for column 'amproc'


# Could not dump table "pg_attrdef" because of following StandardError
#   Unknown type 'pg_node_tree' for column 'adbin'


# Could not dump table "pg_attribute" because of following StandardError
#   Unknown type 'aclitem' for column 'attacl'


  create_table "pg_auth_members", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.oid "roleid", null: false
    t.oid "member", null: false
    t.oid "grantor", null: false
    t.boolean "admin_option", null: false
    t.boolean "inherit_option", null: false
    t.boolean "set_option", null: false
    t.index ["grantor"], name: "pg_auth_members_grantor_index"
    t.unique_constraint ["member", "roleid", "grantor"], name: "pg_auth_members_member_role_index"
    t.unique_constraint ["roleid", "member", "grantor"], name: "pg_auth_members_role_member_index"
  end

  create_table "pg_authid", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.string "rolname", null: false
    t.boolean "rolsuper", null: false
    t.boolean "rolinherit", null: false
    t.boolean "rolcreaterole", null: false
    t.boolean "rolcreatedb", null: false
    t.boolean "rolcanlogin", null: false
    t.boolean "rolreplication", null: false
    t.boolean "rolbypassrls", null: false
    t.integer "rolconnlimit", null: false
    t.text "rolpassword", collation: "C"
    t.timestamptz "rolvaliduntil"

    t.unique_constraint ["rolname"], name: "pg_authid_rolname_index"
  end

  create_table "pg_cast", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.oid "castsource", null: false
    t.oid "casttarget", null: false
    t.oid "castfunc", null: false
    t.string "castcontext", null: false
    t.string "castmethod", null: false

    t.unique_constraint ["castsource", "casttarget"], name: "pg_cast_source_target_index"
  end

# Could not dump table "pg_class" because of following StandardError
#   Unknown type 'xid' for column 'relfrozenxid'


  create_table "pg_collation", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.string "collname", null: false
    t.oid "collnamespace", null: false
    t.oid "collowner", null: false
    t.string "collprovider", null: false
    t.boolean "collisdeterministic", null: false
    t.integer "collencoding", null: false
    t.text "collcollate", collation: "C"
    t.text "collctype", collation: "C"
    t.text "colliculocale", collation: "C"
    t.text "collicurules", collation: "C"
    t.text "collversion", collation: "C"

    t.unique_constraint ["collname", "collencoding", "collnamespace"], name: "pg_collation_name_enc_nsp_index"
  end

# Could not dump table "pg_constraint" because of following StandardError
#   Unknown type 'pg_node_tree' for column 'conbin'


# Could not dump table "pg_conversion" because of following StandardError
#   Unknown type 'regproc' for column 'conproc'


# Could not dump table "pg_database" because of following StandardError
#   Unknown type 'xid' for column 'datfrozenxid'


  create_table "pg_db_role_setting", primary_key: ["setdatabase", "setrole"], force: :cascade do |t|
    t.oid "setdatabase", null: false
    t.oid "setrole", null: false
    t.text "setconfig", collation: "C", array: true
  end

# Could not dump table "pg_default_acl" because of following StandardError
#   Unknown type 'aclitem' for column 'defaclacl'


  create_table "pg_depend", id: false, force: :cascade do |t|
    t.oid "classid", null: false
    t.oid "objid", null: false
    t.integer "objsubid", null: false
    t.oid "refclassid", null: false
    t.oid "refobjid", null: false
    t.integer "refobjsubid", null: false
    t.string "deptype", null: false
    t.index ["classid", "objid", "objsubid"], name: "pg_depend_depender_index"
    t.index ["refclassid", "refobjid", "refobjsubid"], name: "pg_depend_reference_index"
  end

  create_table "pg_description", primary_key: ["objoid", "classoid", "objsubid"], force: :cascade do |t|
    t.oid "objoid", null: false
    t.oid "classoid", null: false
    t.integer "objsubid", null: false
    t.text "description", null: false, collation: "C"
  end

  create_table "pg_enum", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.oid "enumtypid", null: false
    t.float "enumsortorder", limit: 24, null: false
    t.string "enumlabel", null: false

    t.unique_constraint ["enumtypid", "enumlabel"], name: "pg_enum_typid_label_index"
    t.unique_constraint ["enumtypid", "enumsortorder"], name: "pg_enum_typid_sortorder_index"
  end

  create_table "pg_event_trigger", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.string "evtname", null: false
    t.string "evtevent", null: false
    t.oid "evtowner", null: false
    t.oid "evtfoid", null: false
    t.string "evtenabled", null: false
    t.text "evttags", collation: "C", array: true

    t.unique_constraint ["evtname"], name: "pg_event_trigger_evtname_index"
  end

  create_table "pg_extension", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.string "extname", null: false
    t.oid "extowner", null: false
    t.oid "extnamespace", null: false
    t.boolean "extrelocatable", null: false
    t.text "extversion", null: false, collation: "C"
    t.oid "extconfig", array: true
    t.text "extcondition", collation: "C", array: true

    t.unique_constraint ["extname"], name: "pg_extension_name_index"
  end

# Could not dump table "pg_foreign_data_wrapper" because of following StandardError
#   Unknown type 'aclitem' for column 'fdwacl'


# Could not dump table "pg_foreign_server" because of following StandardError
#   Unknown type 'aclitem' for column 'srvacl'


  create_table "pg_foreign_table", primary_key: "ftrelid", id: :oid, force: :cascade do |t|
    t.oid "ftserver", null: false
    t.text "ftoptions", collation: "C", array: true
  end

# Could not dump table "pg_index" because of following StandardError
#   Unknown type 'int2vector' for column 'indkey'


  create_table "pg_inherits", primary_key: ["inhrelid", "inhseqno"], force: :cascade do |t|
    t.oid "inhrelid", null: false
    t.oid "inhparent", null: false
    t.integer "inhseqno", null: false
    t.boolean "inhdetachpending", null: false
    t.index ["inhparent"], name: "pg_inherits_parent_index"
  end

# Could not dump table "pg_init_privs" because of following StandardError
#   Unknown type 'aclitem' for column 'initprivs'


# Could not dump table "pg_language" because of following StandardError
#   Unknown type 'aclitem' for column 'lanacl'


  create_table "pg_largeobject", primary_key: ["loid", "pageno"], force: :cascade do |t|
    t.oid "loid", null: false
    t.integer "pageno", null: false
    t.binary "data", null: false
  end

# Could not dump table "pg_largeobject_metadata" because of following StandardError
#   Unknown type 'aclitem' for column 'lomacl'


# Could not dump table "pg_namespace" because of following StandardError
#   Unknown type 'aclitem' for column 'nspacl'


  create_table "pg_opclass", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.oid "opcmethod", null: false
    t.string "opcname", null: false
    t.oid "opcnamespace", null: false
    t.oid "opcowner", null: false
    t.oid "opcfamily", null: false
    t.oid "opcintype", null: false
    t.boolean "opcdefault", null: false
    t.oid "opckeytype", null: false

    t.unique_constraint ["opcmethod", "opcname", "opcnamespace"], name: "pg_opclass_am_name_nsp_index"
  end

# Could not dump table "pg_operator" because of following StandardError
#   Unknown type 'regproc' for column 'oprcode'


  create_table "pg_opfamily", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.oid "opfmethod", null: false
    t.string "opfname", null: false
    t.oid "opfnamespace", null: false
    t.oid "opfowner", null: false

    t.unique_constraint ["opfmethod", "opfname", "opfnamespace"], name: "pg_opfamily_am_name_nsp_index"
  end

# Could not dump table "pg_parameter_acl" because of following StandardError
#   Unknown type 'aclitem' for column 'paracl'


# Could not dump table "pg_partitioned_table" because of following StandardError
#   Unknown type 'int2vector' for column 'partattrs'


# Could not dump table "pg_policy" because of following StandardError
#   Unknown type 'pg_node_tree' for column 'polqual'


# Could not dump table "pg_proc" because of following StandardError
#   Unknown type 'regproc' for column 'prosupport'


  create_table "pg_publication", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.string "pubname", null: false
    t.oid "pubowner", null: false
    t.boolean "puballtables", null: false
    t.boolean "pubinsert", null: false
    t.boolean "pubupdate", null: false
    t.boolean "pubdelete", null: false
    t.boolean "pubtruncate", null: false
    t.boolean "pubviaroot", null: false

    t.unique_constraint ["pubname"], name: "pg_publication_pubname_index"
  end

  create_table "pg_publication_namespace", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.oid "pnpubid", null: false
    t.oid "pnnspid", null: false

    t.unique_constraint ["pnnspid", "pnpubid"], name: "pg_publication_namespace_pnnspid_pnpubid_index"
  end

# Could not dump table "pg_publication_rel" because of following StandardError
#   Unknown type 'pg_node_tree' for column 'prqual'


# Could not dump table "pg_range" because of following StandardError
#   Unknown type 'regproc' for column 'rngcanonical'


  create_table "pg_replication_origin", primary_key: "roident", id: :oid, force: :cascade do |t|
    t.text "roname", null: false, collation: "C"

    t.unique_constraint ["roname"], name: "pg_replication_origin_roname_index"
  end

# Could not dump table "pg_rewrite" because of following StandardError
#   Unknown type 'pg_node_tree' for column 'ev_qual'


  create_table "pg_seclabel", primary_key: ["objoid", "classoid", "objsubid", "provider"], force: :cascade do |t|
    t.oid "objoid", null: false
    t.oid "classoid", null: false
    t.integer "objsubid", null: false
    t.text "provider", null: false, collation: "C"
    t.text "label", null: false, collation: "C"
  end

  create_table "pg_sequence", primary_key: "seqrelid", id: :oid, force: :cascade do |t|
    t.oid "seqtypid", null: false
    t.bigint "seqstart", null: false
    t.bigint "seqincrement", null: false
    t.bigint "seqmax", null: false
    t.bigint "seqmin", null: false
    t.bigint "seqcache", null: false
    t.boolean "seqcycle", null: false
  end

  create_table "pg_shdepend", id: false, force: :cascade do |t|
    t.oid "dbid", null: false
    t.oid "classid", null: false
    t.oid "objid", null: false
    t.integer "objsubid", null: false
    t.oid "refclassid", null: false
    t.oid "refobjid", null: false
    t.string "deptype", null: false
    t.index ["dbid", "classid", "objid", "objsubid"], name: "pg_shdepend_depender_index"
    t.index ["refclassid", "refobjid"], name: "pg_shdepend_reference_index"
  end

  create_table "pg_shdescription", primary_key: ["objoid", "classoid"], force: :cascade do |t|
    t.oid "objoid", null: false
    t.oid "classoid", null: false
    t.text "description", null: false, collation: "C"
  end

  create_table "pg_shseclabel", primary_key: ["objoid", "classoid", "provider"], force: :cascade do |t|
    t.oid "objoid", null: false
    t.oid "classoid", null: false
    t.text "provider", null: false, collation: "C"
    t.text "label", null: false, collation: "C"
  end

# Could not dump table "pg_statistic" because of following StandardError
#   Unknown type 'anyarray' for column 'stavalues1'


# Could not dump table "pg_statistic_ext" because of following StandardError
#   Unknown type 'int2vector' for column 'stxkeys'


# Could not dump table "pg_statistic_ext_data" because of following StandardError
#   Unknown type 'pg_ndistinct' for column 'stxdndistinct'


# Could not dump table "pg_subscription" because of following StandardError
#   Unknown type 'pg_lsn' for column 'subskiplsn'


# Could not dump table "pg_subscription_rel" because of following StandardError
#   Unknown type 'pg_lsn' for column 'srsublsn'


# Could not dump table "pg_tablespace" because of following StandardError
#   Unknown type 'aclitem' for column 'spcacl'


# Could not dump table "pg_transform" because of following StandardError
#   Unknown type 'regproc' for column 'trffromsql'


# Could not dump table "pg_trigger" because of following StandardError
#   Unknown type 'int2vector' for column 'tgattr'


  create_table "pg_ts_config", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.string "cfgname", null: false
    t.oid "cfgnamespace", null: false
    t.oid "cfgowner", null: false
    t.oid "cfgparser", null: false

    t.unique_constraint ["cfgname", "cfgnamespace"], name: "pg_ts_config_cfgname_index"
  end

  create_table "pg_ts_config_map", primary_key: ["mapcfg", "maptokentype", "mapseqno"], force: :cascade do |t|
    t.oid "mapcfg", null: false
    t.integer "maptokentype", null: false
    t.integer "mapseqno", null: false
    t.oid "mapdict", null: false
  end

  create_table "pg_ts_dict", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.string "dictname", null: false
    t.oid "dictnamespace", null: false
    t.oid "dictowner", null: false
    t.oid "dicttemplate", null: false
    t.text "dictinitoption", collation: "C"

    t.unique_constraint ["dictname", "dictnamespace"], name: "pg_ts_dict_dictname_index"
  end

# Could not dump table "pg_ts_parser" because of following StandardError
#   Unknown type 'regproc' for column 'prsstart'


# Could not dump table "pg_ts_template" because of following StandardError
#   Unknown type 'regproc' for column 'tmplinit'


# Could not dump table "pg_type" because of following StandardError
#   Unknown type 'regproc' for column 'typsubscript'


  create_table "pg_user_mapping", primary_key: "oid", id: :oid, force: :cascade do |t|
    t.oid "umuser", null: false
    t.oid "umserver", null: false
    t.text "umoptions", collation: "C", array: true

    t.unique_constraint ["umuser", "umserver"], name: "pg_user_mapping_user_server_index"
  end

  create_table "secrets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "otp_secret"
    t.integer "last_otp_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", using: :pgroonga
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
