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

ActiveRecord::Schema.define(version: 20140124050123) do

  create_table "admin_activities", force: true do |t|
    t.integer  "UserID",      null: false
    t.integer  "OPCode",      null: false
    t.integer  "TaskID",      null: false
    t.datetime "DateCreated", null: false
  end

  create_table "admin_login_report_histories", force: true do |t|
    t.integer  "UserID",         null: false
    t.datetime "LoginDateTime",  null: false
    t.datetime "LogOutDateTime"
  end

  create_table "admin_login_reports", force: true do |t|
    t.integer  "UserID",         null: false
    t.datetime "LoginDateTime",  null: false
    t.datetime "LogOutDateTime"
  end

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

  create_table "customer_review_joins", force: true do |t|
    t.integer  "CustomerSearchID", null: false
    t.integer  "UserID",           null: false
    t.boolean  "IsReviewGiven",    null: false
    t.boolean  "IsRequestSent",    null: false
    t.datetime "DateCreated",      null: false
    t.datetime "DateUpdated",      null: false
  end

  create_table "customer_search_logs", force: true do |t|
    t.integer  "CustomerSearchID", null: false
    t.datetime "SearchedDateTime", null: false
  end

  create_table "customer_searches", force: true do |t|
    t.string   "FirstName",  limit: 50, null: false
    t.string   "LastName",   limit: 50, null: false
    t.integer  "AddressID",             null: false
    t.datetime "SearchDate",            null: false
  end

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

  create_table "faq_histories", force: true do |t|
    t.integer  "ReportID",                null: false
    t.string   "Question",    limit: 200, null: false
    t.text     "Answers",                 null: false
    t.boolean  "IsEnabled",               null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

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

  create_table "liens_histories", force: true do |t|
    t.integer  "ReportID",    null: false
    t.integer  "AddressID",   null: false
    t.integer  "GrantorID",   null: false
    t.datetime "DateIssued",  null: false
    t.float    "Amount",      null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  create_table "ml_judgement_histories", force: true do |t|
    t.integer  "ReportID",     null: false
    t.integer  "AddressID",    null: false
    t.text     "MLJudgements"
    t.datetime "DateCreated",  null: false
    t.datetime "DateUpdated",  null: false
  end

  create_table "ml_judgements", force: true do |t|
    t.integer  "AddressID",    null: false
    t.text     "MLJudgements"
    t.datetime "DateCreated",  null: false
    t.datetime "DateUpdated",  null: false
  end

  create_table "news_update_histories", force: true do |t|
    t.integer  "ReportID",    null: false
    t.text     "Comments",    null: false
    t.boolean  "IsEnabled",   null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

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

  create_table "review_answer_histories", force: true do |t|
    t.integer  "ReviewID",               null: false
    t.integer  "QuestionID",             null: false
    t.text     "Comments"
    t.string   "IsYes",       limit: 50
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  create_table "review_answer_history_reports", force: true do |t|
    t.integer  "ReportID",               null: false
    t.integer  "ReviewID",               null: false
    t.integer  "QuestionID",             null: false
    t.text     "Comments",               null: false
    t.string   "IsYes",       limit: 50, null: false
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  create_table "review_answers", force: true do |t|
    t.integer  "ReviewID",               null: false
    t.integer  "QuestionID",             null: false
    t.text     "Comments"
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
    t.string   "IsYes",       limit: 50
  end

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

  create_table "site_content_histories", force: true do |t|
    t.integer  "ReportID",                null: false
    t.integer  "PageCode",    limit: 3,   null: false
    t.string   "Title",       limit: 100, null: false
    t.text     "Content",                 null: false
    t.boolean  "IsEnabled",               null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  create_table "site_contents", force: true do |t|
    t.integer  "PageCode",                null: false
    t.string   "Title",       limit: 100, null: false
    t.text     "Content",                 null: false
    t.integer  "IsEnabled",               null: false
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

  create_table "site_module_user_joins", force: true do |t|
    t.integer  "ModuleID",    null: false
    t.integer  "UserID",      null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

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

  create_table "site_users", force: true do |t|
    t.string   "UserName",     limit: 20,  null: false
    t.string   "Password",     limit: 100, null: false
    t.string   "Salt",         limit: 45,  null: false
    t.string   "FirstName",    limit: 20,  null: false
    t.string   "LastName",     limit: 20,  null: false
    t.string   "EmailID",      limit: 50,  null: false
    t.datetime "DateCreated",              null: false
    t.boolean  "IsActivated",              null: false
    t.boolean  "IsSuperAdmin",             null: false
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
    t.datetime "DateCreated",                   null: false
    t.datetime "DateUpdated",                   null: false
  end

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

  create_table "user_login_report_histories", force: true do |t|
    t.integer  "UserID",         null: false
    t.datetime "LoginDateTime",  null: false
    t.datetime "LogOutDateTime"
  end

  create_table "user_login_reports", force: true do |t|
    t.integer  "UserID",         null: false
    t.datetime "LoginDateTime",  null: false
    t.datetime "LogOutDateTime"
  end

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

  create_table "user_subscription_plans", force: true do |t|
    t.string   "PlanType",        limit: 50,  null: false
    t.string   "PlanDescription", limit: 200, null: false
    t.string   "price",           limit: 10,  null: false
    t.datetime "DateCreated",                 null: false
    t.datetime "DateUpdated",                 null: false
  end

end
