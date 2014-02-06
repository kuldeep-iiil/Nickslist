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

ActiveRecord::Schema.define(version: 20140205164228) do

  create_table "admin_activities", force: true do |t|
    t.integer  "UserID",      null: false
    t.integer  "OPCode",      null: false
    t.integer  "TaskID",      null: false
    t.datetime "DateCreated", null: false
  end

  add_index "admin_activities", ["UserID"], name: "fk_admin_activities_UserID", using: :btree

  create_table "admin_login_report_histories", force: true do |t|
    t.integer  "UserID",         null: false
    t.datetime "LoginDateTime",  null: false
    t.datetime "LogOutDateTime"
  end

  add_index "admin_login_report_histories", ["UserID"], name: "fk_sadmin_login_report_histories_UserID", using: :btree

  create_table "admin_login_reports", force: true do |t|
    t.integer  "UserID",         null: false
    t.datetime "LoginDateTime",  null: false
    t.datetime "LogOutDateTime"
  end

  add_index "admin_login_reports", ["UserID"], name: "fk_admin_login_reports_UserID", using: :btree

  create_table "court_proceeding_histories", force: true do |t|
    t.integer  "ReportID",                    null: false
    t.integer  "AddressID",                   null: false
    t.integer  "PlaintiffID",                 null: false
    t.integer  "DefendantID",                 null: false
    t.string   "CaseType",         limit: 30, null: false
    t.datetime "CourtHearingDate",            null: false
    t.datetime "DateFiled",                   null: false
    t.float    "AmountAwarded",               null: false
    t.datetime "DateCreated",                 null: false
    t.datetime "DateUpdated",                 null: false
  end

  add_index "court_proceeding_histories", ["AddressID"], name: "fk_court_proceeding_histories_AddressID", using: :btree
  add_index "court_proceeding_histories", ["DefendantID"], name: "fk_court_proceeding_histories_DefendantID", using: :btree
  add_index "court_proceeding_histories", ["PlaintiffID"], name: "fk_court_proceeding_histories_PlaintiffID", using: :btree
  add_index "court_proceeding_histories", ["ReportID"], name: "fk_court_proceeding_histories_ReportID", using: :btree

  create_table "court_proceedings", force: true do |t|
    t.integer  "AddressID",                   null: false
    t.integer  "PlaintiffID",                 null: false
    t.integer  "DefendantID",                 null: false
    t.string   "CaseType",         limit: 30, null: false
    t.datetime "CourtHearingDate",            null: false
    t.datetime "DateFiled",                   null: false
    t.float    "AmountAwarded",               null: false
    t.datetime "DateCreated",                 null: false
    t.datetime "DateUpdated",                 null: false
  end

  add_index "court_proceedings", ["AddressID"], name: "fk_court_proceedings_AddressID", using: :btree
  add_index "court_proceedings", ["DefendantID"], name: "fk_court_proceedings_DefendantID", using: :btree
  add_index "court_proceedings", ["PlaintiffID"], name: "fk_court_proceedings_PlaintiffID", using: :btree

  create_table "customer_addresses", force: true do |t|
    t.string   "StreetAddress", limit: 100, null: false
    t.string   "City",          limit: 50,  null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 10,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  create_table "customer_phones", force: true do |t|
    t.integer  "CustomerSearchID",            null: false
    t.string   "ContactNumber",    limit: 20, null: false
    t.datetime "DateCreated",                 null: false
  end

  add_index "customer_phones", ["CustomerSearchID"], name: "fk_customer_phones_CustSearchID", using: :btree

  create_table "customer_review_joins", force: true do |t|
    t.integer  "CustomerSearchID", null: false
    t.integer  "UserID",           null: false
    t.boolean  "IsReviewGiven",    null: false
    t.boolean  "IsRequestSent",    null: false
    t.datetime "DateCreated",      null: false
    t.datetime "DateUpdated",      null: false
  end

  add_index "customer_review_joins", ["CustomerSearchID"], name: "fk_customer_review_joins_CustSearchID", using: :btree
  add_index "customer_review_joins", ["UserID"], name: "fk_customer_review_joins_UserID", using: :btree

  create_table "customer_search_logs", force: true do |t|
    t.integer  "CustomerSearchID", null: false
    t.integer  "UserID",           null: false
    t.datetime "SearchedDateTime", null: false
  end

  add_index "customer_search_logs", ["CustomerSearchID"], name: "fk_customer_search_logs_CustSearchID", using: :btree
  add_index "customer_search_logs", ["UserID"], name: "fk_customer_search_logs_UserID", using: :btree

  create_table "customer_searches", force: true do |t|
    t.string   "FirstName",  limit: 50, null: false
    t.string   "LastName",   limit: 50, null: false
    t.integer  "AddressID",             null: false
    t.datetime "SearchDate",            null: false
  end

  add_index "customer_searches", ["AddressID"], name: "fk_customer_searches_AddressID", using: :btree

  create_table "defendants", force: true do |t|
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 100, null: false
    t.string   "City",          limit: 50,  null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 10,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  create_table "defendants_histories", force: true do |t|
    t.integer  "ReportID",                  null: false
    t.integer  "DefendantID",               null: false
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 100, null: false
    t.string   "City",          limit: 50,  null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 10,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  add_index "defendants_histories", ["DefendantID"], name: "fk_defendants_histories_DefendantID", using: :btree
  add_index "defendants_histories", ["ReportID"], name: "fk_defendants_histories_ReportID", using: :btree

  create_table "faq_histories", force: true do |t|
    t.integer  "ReportID",                null: false
    t.string   "Question",    limit: 200, null: false
    t.text     "Answers",                 null: false
    t.boolean  "IsEnabled",               null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  add_index "faq_histories", ["ReportID"], name: "fk_faq_histories_ReportID", using: :btree

  create_table "faqs", force: true do |t|
    t.string   "Question",    limit: 200, null: false
    t.text     "Answers",                 null: false
    t.boolean  "IsEnabled",               null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  create_table "grantors", force: true do |t|
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 100, null: false
    t.string   "City",          limit: 50,  null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 10,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  create_table "grantors_histories", force: true do |t|
    t.integer  "ReportID",                  null: false
    t.integer  "GrantorID",                 null: false
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 100, null: false
    t.string   "City",          limit: 50,  null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 10,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  add_index "grantors_histories", ["GrantorID"], name: "fk_grantors_histories_GrantorID", using: :btree
  add_index "grantors_histories", ["ReportID"], name: "fk_grantors_histories_ReportID", using: :btree

  create_table "keys", force: true do |t|
    t.integer  "UserID",                 null: false
    t.string   "Key",         limit: 50, null: false
    t.datetime "DateCreated",            null: false
  end

  create_table "liens", force: true do |t|
    t.integer  "AddressID",   null: false
    t.integer  "GrantorID",   null: false
    t.datetime "DateIssued",  null: false
    t.float    "Amount",      null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "liens", ["AddressID"], name: "fk_liens_AddressID", using: :btree
  add_index "liens", ["GrantorID"], name: "fk_liens_GrantorID", using: :btree

  create_table "liens_histories", force: true do |t|
    t.integer  "ReportID",    null: false
    t.integer  "AddressID",   null: false
    t.integer  "GrantorID",   null: false
    t.datetime "DateIssued",  null: false
    t.float    "Amount",      null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "liens_histories", ["AddressID"], name: "fk_liens_histories_AddressID", using: :btree
  add_index "liens_histories", ["GrantorID"], name: "fk_liens_histories_GrantorID", using: :btree
  add_index "liens_histories", ["ReportID"], name: "fk_liens_histories_ReportID", using: :btree

  create_table "ml_judgement_histories", force: true do |t|
    t.integer  "ReportID",     null: false
    t.integer  "AddressID",    null: false
    t.text     "MLJudgements"
    t.datetime "DateCreated",  null: false
    t.datetime "DateUpdated",  null: false
  end

  add_index "ml_judgement_histories", ["AddressID"], name: "fk_ml_judgement_histories_AddressID", using: :btree
  add_index "ml_judgement_histories", ["ReportID"], name: "fk_ml_judgement_histories_ReportID", using: :btree

  create_table "ml_judgements", force: true do |t|
    t.integer  "AddressID",    null: false
    t.text     "MLJudgements"
    t.datetime "DateCreated",  null: false
    t.datetime "DateUpdated",  null: false
  end

  add_index "ml_judgements", ["AddressID"], name: "fk_ml_judgements_AddressID", using: :btree

  create_table "news_update_histories", force: true do |t|
    t.integer  "ReportID",    null: false
    t.text     "Comments",    null: false
    t.boolean  "IsEnabled",   null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "news_update_histories", ["ReportID"], name: "fk_news_update_histories_ReportID", using: :btree

  create_table "news_updates", force: true do |t|
    t.text     "Comments",    null: false
    t.boolean  "IsEnabled",   null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  create_table "operation_lists", force: true do |t|
    t.integer  "OPCode",                  null: false
    t.string   "Operation",   limit: 200, null: false
    t.datetime "DateCreated",             null: false
  end

  create_table "plaintiffs", force: true do |t|
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 100, null: false
    t.string   "City",          limit: 50,  null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 10,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  create_table "plaintiffs_histories", force: true do |t|
    t.integer  "ReportID",                  null: false
    t.integer  "PlaintiffID",               null: false
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 100, null: false
    t.string   "City",          limit: 50,  null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 10,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  add_index "plaintiffs_histories", ["PlaintiffID"], name: "fk_plaintiffs_histories_PlaintiffID", using: :btree
  add_index "plaintiffs_histories", ["ReportID"], name: "fk_plaintiffs_histories_ReportID", using: :btree

  create_table "review_answer_histories", force: true do |t|
    t.integer  "ReviewID",               null: false
    t.integer  "QuestionID",             null: false
    t.text     "Comments"
    t.string   "IsYes",       limit: 50
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  add_index "review_answer_histories", ["QuestionID"], name: "fk_review_answer_histories_QuestionID", using: :btree
  add_index "review_answer_histories", ["ReviewID"], name: "fk_review_answer_histories_ReviewID", using: :btree

  create_table "review_answer_history_reports", force: true do |t|
    t.integer  "ReportID",               null: false
    t.integer  "ReviewID",               null: false
    t.integer  "QuestionID",             null: false
    t.text     "Comments"
    t.string   "IsYes",       limit: 50
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  add_index "review_answer_history_reports", ["QuestionID"], name: "fk_review_answer_history_reports_QuestionID", using: :btree
  add_index "review_answer_history_reports", ["ReportID"], name: "fk_review_answer_history_reports_ReportID", using: :btree
  add_index "review_answer_history_reports", ["ReviewID"], name: "fk_review_answer_history_reports_ReviewID", using: :btree

  create_table "review_answers", force: true do |t|
    t.integer  "ReviewID",               null: false
    t.integer  "QuestionID",             null: false
    t.text     "Comments"
    t.string   "IsYes",       limit: 50
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  add_index "review_answers", ["QuestionID"], name: "fk_review_answers_QuestionID", using: :btree
  add_index "review_answers", ["ReviewID"], name: "fk_review_answers_ReviewID", using: :btree

  create_table "review_questions", force: true do |t|
    t.integer  "ParentID"
    t.text     "Description",            null: false
    t.string   "Type",        limit: 45, null: false
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  create_table "reviews", force: true do |t|
    t.integer  "UserID",           null: false
    t.integer  "CustomerSearchID", null: false
    t.boolean  "IsPublished",      null: false
    t.boolean  "IsApproved",       null: false
    t.datetime "DateCreated",      null: false
    t.datetime "DateUpdated",      null: false
  end

  add_index "reviews", ["CustomerSearchID"], name: "fk_reviews_CustSearchID", using: :btree
  add_index "reviews", ["UserID"], name: "fk_reviews_UserID", using: :btree

  create_table "site_content_histories", force: true do |t|
    t.integer  "ReportID",                null: false
    t.integer  "PageCode",                null: false
    t.string   "Title",       limit: 100, null: false
    t.text     "Content",                 null: false
    t.boolean  "IsEnabled",               null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  add_index "site_content_histories", ["ReportID"], name: "fk_site_content_histories_ReportID", using: :btree

  create_table "site_contents", force: true do |t|
    t.integer  "PageCode",    limit: 3,   null: false
    t.string   "Title",       limit: 100, null: false
    t.text     "Content",                 null: false
    t.boolean  "IsEnabled",               null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  create_table "site_module_user_join_histories", force: true do |t|
    t.integer  "ReportID",    null: false
    t.integer  "ModuleID",    null: false
    t.integer  "UserID",      null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "site_module_user_join_histories", ["ModuleID"], name: "fk_site_module_user_join_histories_ModuleID", using: :btree
  add_index "site_module_user_join_histories", ["ReportID"], name: "fk_site_module_user_join_histories_ReportID", using: :btree
  add_index "site_module_user_join_histories", ["UserID"], name: "fk_site_module_user_join_histories_UserID", using: :btree

  create_table "site_module_user_joins", force: true do |t|
    t.integer  "ModuleID",    null: false
    t.integer  "UserID",      null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "site_module_user_joins", ["ModuleID"], name: "fk_site_module_user_joins_ModuleID", using: :btree
  add_index "site_module_user_joins", ["UserID"], name: "fk_site_module_user_joins_UserID", using: :btree

  create_table "site_modules", force: true do |t|
    t.string   "Module",      limit: 20,  null: false
    t.string   "Description", limit: 100, null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  create_table "site_user_histories", force: true do |t|
    t.integer  "ReportID",                 null: false
    t.integer  "UserID",                   null: false
    t.string   "UserName",     limit: 20,  null: false
    t.string   "Password",     limit: 100, null: false
    t.string   "Salt",         limit: 45,  null: false
    t.string   "FirstName",    limit: 20,  null: false
    t.string   "LastName",     limit: 20,  null: false
    t.string   "EmailID",      limit: 50,  null: false
    t.boolean  "IsActivated",              null: false
    t.boolean  "IsSuperAdmin",             null: false
    t.datetime "DateCreated",              null: false
    t.datetime "DateUpdated",              null: false
  end

  add_index "site_user_histories", ["ReportID"], name: "fk_site_user_histories_ReportID", using: :btree
  add_index "site_user_histories", ["UserID"], name: "fk_site_user_histories_UserID", using: :btree

  create_table "site_users", force: true do |t|
    t.string   "UserName",     limit: 20,  null: false
    t.string   "Password",     limit: 100, null: false
    t.string   "Salt",         limit: 45,  null: false
    t.string   "FirstName",    limit: 20,  null: false
    t.string   "LastName",     limit: 20,  null: false
    t.string   "EmailID",      limit: 50,  null: false
    t.boolean  "IsActivated",              null: false
    t.boolean  "IsSuperAdmin",             null: false
    t.datetime "DateCreated",              null: false
    t.datetime "DateUpdated",              null: false
  end

  create_table "subscribed_user_histories", force: true do |t|
    t.integer  "ReportID",                      null: false
    t.integer  "UserID",                        null: false
    t.string   "UserName",          limit: 20,  null: false
    t.string   "Password",          limit: 100, null: false
    t.string   "Salt",              limit: 45,  null: false
    t.string   "FirstName",         limit: 20,  null: false
    t.string   "MiddleName",        limit: 20
    t.string   "LastName",          limit: 20,  null: false
    t.string   "EmailID",           limit: 50,  null: false
    t.string   "CompanyName",       limit: 100, null: false
    t.string   "IncorporationType", limit: 20,  null: false
    t.string   "ContactNumber",     limit: 20,  null: false
    t.string   "LicenseNumber",     limit: 20,  null: false
    t.string   "AuthCodeUsed",      limit: 45
    t.boolean  "IsActivated",                   null: false
    t.boolean  "IsSubscribed",                  null: false
    t.boolean  "IsNotification",                null: false
    t.datetime "DateCreated",                   null: false
    t.datetime "DateUpdated",                   null: false
  end

  add_index "subscribed_user_histories", ["ReportID"], name: "fk_subscribed_user_histories_ReportID", using: :btree
  add_index "subscribed_user_histories", ["UserID"], name: "fk_subscribed_user_histories_UserID", using: :btree

  create_table "subscribed_users", force: true do |t|
    t.string   "UserName",          limit: 20,  null: false
    t.string   "Password",          limit: 100, null: false
    t.string   "Salt",              limit: 45,  null: false
    t.string   "FirstName",         limit: 20,  null: false
    t.string   "MiddleName",        limit: 20
    t.string   "LastName",          limit: 20,  null: false
    t.string   "EmailID",           limit: 50,  null: false
    t.string   "CompanyName",       limit: 100, null: false
    t.string   "IncorporationType", limit: 20,  null: false
    t.string   "ContactNumber",     limit: 20,  null: false
    t.string   "LicenseNumber",     limit: 20,  null: false
    t.string   "AuthCodeUsed",      limit: 45
    t.boolean  "IsActivated",                   null: false
    t.boolean  "IsSubscribed",                  null: false
    t.boolean  "IsNotification",                null: false
    t.datetime "DateCreated",                   null: false
    t.datetime "DateUpdated",                   null: false
  end

  create_table "testimonial_histories", force: true do |t|
    t.integer  "ReportID",               null: false
    t.string   "FirstName",   limit: 20, null: false
    t.string   "LastName",    limit: 20, null: false
    t.string   "Occupation",  limit: 20, null: false
    t.text     "Comments",               null: false
    t.boolean  "IsEnabled",              null: false
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  add_index "testimonial_histories", ["ReportID"], name: "fk_testimonial_histories_ReportID", using: :btree

  create_table "testimonials", force: true do |t|
    t.string   "FirstName",   limit: 20, null: false
    t.string   "LastName",    limit: 20, null: false
    t.string   "Occupation",  limit: 20, null: false
    t.text     "Comments",               null: false
    t.boolean  "IsEnabled",              null: false
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  create_table "user_address_detail_histories", force: true do |t|
    t.integer  "ReportID",                null: false
    t.integer  "UserID",                  null: false
    t.string   "AddressType", limit: 20,  null: false
    t.string   "Address",     limit: 100, null: false
    t.string   "City",        limit: 50,  null: false
    t.string   "State",       limit: 20,  null: false
    t.string   "ZipCode",     limit: 10,  null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  add_index "user_address_detail_histories", ["ReportID"], name: "fk_user_address_detail_histories_ReportID", using: :btree
  add_index "user_address_detail_histories", ["UserID"], name: "fk_user_address_detail_histories_UserID", using: :btree

  create_table "user_address_details", force: true do |t|
    t.integer  "UserID",                  null: false
    t.string   "AddressType", limit: 20,  null: false
    t.string   "Address",     limit: 100, null: false
    t.string   "City",        limit: 50,  null: false
    t.string   "State",       limit: 20,  null: false
    t.string   "ZipCode",     limit: 10,  null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  add_index "user_address_details", ["UserID"], name: "fk_user_address_details_UserID", using: :btree

  create_table "user_login_report_histories", force: true do |t|
    t.integer  "UserID",         null: false
    t.datetime "LoginDateTime",  null: false
    t.datetime "LogOutDateTime"
  end

  add_index "user_login_report_histories", ["UserID"], name: "fk_user_login_report_histories_UserID", using: :btree

  create_table "user_login_reports", force: true do |t|
    t.integer  "UserID",         null: false
    t.datetime "LoginDateTime",  null: false
    t.datetime "LogOutDateTime"
  end

  add_index "user_login_reports", ["UserID"], name: "fk_user_login_reports_UserID", using: :btree

  create_table "user_payment_details", force: true do |t|
    t.integer  "UserID",                       null: false
    t.string   "TransactionAmount", limit: 10, null: false
    t.string   "BLTransactionID",   limit: 50
    t.string   "PayTransactionID",  limit: 50, null: false
    t.boolean  "PaymentStatus"
    t.datetime "ResponseDateTime"
    t.text     "ResponseString",               null: false
    t.datetime "DateCreated",                  null: false
    t.datetime "DateUpdated",                  null: false
  end

  add_index "user_payment_details", ["UserID"], name: "fk_user_payment_details_UserID", using: :btree

  create_table "user_subscription_plans", force: true do |t|
    t.string   "PlanType",        limit: 50,  null: false
    t.string   "PlanDescription", limit: 200, null: false
    t.string   "price",           limit: 10,  null: false
    t.datetime "DateCreated",                 null: false
    t.datetime "DateUpdated",                 null: false
  end

end
