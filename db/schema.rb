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

ActiveRecord::Schema.define(version: 20131031072138) do

  create_table "AddressTypes", primary_key: "ID", force: true do |t|
    t.string   "Name",        limit: 20, null: false
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  create_table "CaseTypes", primary_key: "ID", force: true do |t|
    t.string   "Name",        limit: 20, null: false
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  create_table "Cities", primary_key: "ID", force: true do |t|
    t.string "Name",  limit: 20, null: false
    t.string "State", limit: 20, null: false
  end

  add_index "Cities", ["ID"], name: "ID_UNIQUE", unique: true, using: :btree

  create_table "CourtProceedings", primary_key: "ID", force: true do |t|
    t.integer  "PlaintiffID",      null: false
    t.integer  "DefendantID",      null: false
    t.datetime "DateFiled",        null: false
    t.datetime "CourtHearingDate", null: false
    t.float    "AmountAwarded",    null: false
    t.datetime "DateCreated",      null: false
    t.datetime "DateUpdated",      null: false
  end

  add_index "CourtProceedings", ["DefendantID"], name: "fk_DefendantID", using: :btree
  add_index "CourtProceedings", ["PlaintiffID"], name: "fk_PlaintiffID", using: :btree

  create_table "Customers", primary_key: "ID", force: true do |t|
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "MiddleName",    limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "ContactNumber", limit: 20,  null: false
    t.string   "StreetAddress", limit: 20,  null: false
    t.string   "City",          limit: 100, null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZIPCode",       limit: 20,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  add_index "Customers", ["City"], name: "fk_CustomersCityID", using: :btree
  add_index "Customers", ["State"], name: "fk_CustomersStateID", using: :btree

  create_table "Defendants", primary_key: "ID", force: true do |t|
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "MiddleName",    limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 20,  null: false
    t.string   "City",          limit: 100, null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 20,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  add_index "Defendants", ["City"], name: "fk_DefendantsCityID", using: :btree
  add_index "Defendants", ["State"], name: "fk_DefendantsStateID", using: :btree

  create_table "DetailedInfoReviews", primary_key: "ID", force: true do |t|
    t.integer "ReviewID",               null: false
    t.integer "QuestionID",             null: false
    t.text    "Comments",               null: false
    t.binary  "IsYes",       limit: 1,  null: false
    t.string  "DateCreated", limit: 45, null: false
    t.string  "DateUpdated", limit: 45, null: false
  end

  add_index "DetailedInfoReviews", ["QuestionID"], name: "fk_DetailedQuestionID", using: :btree
  add_index "DetailedInfoReviews", ["ReviewID"], name: "fk_DetailedReviewID", using: :btree

  create_table "GeneralInfoReviews", primary_key: "ID", force: true do |t|
    t.integer  "ReviewID",              null: false
    t.integer  "QuestionID",            null: false
    t.text     "Comments",              null: false
    t.binary   "isYes",       limit: 1, null: false
    t.datetime "DateCreated",           null: false
    t.datetime "DateUpdated",           null: false
  end

  add_index "GeneralInfoReviews", ["QuestionID"], name: "fk_GeneralQuestionID", using: :btree
  add_index "GeneralInfoReviews", ["ReviewID"], name: "fk_GeneralReviewID", using: :btree

  create_table "Grantors", primary_key: "ID", force: true do |t|
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "MiddleName",    limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 20,  null: false
    t.string   "City",          limit: 100, null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 20,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  add_index "Grantors", ["City"], name: "fk_GrantorsCityID", using: :btree
  add_index "Grantors", ["State"], name: "fk_GrantorsStateID", using: :btree

  create_table "IncorporationTypes", primary_key: "ID", force: true do |t|
    t.string   "Name",        limit: 20, null: false
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  create_table "Keys", primary_key: "ID", force: true do |t|
    t.integer  "UserID",                 null: false
    t.string   "Key",         limit: 45, null: false
    t.datetime "DateCreated",            null: false
  end

  add_index "Keys", ["ID"], name: "ID_UNIQUE", unique: true, using: :btree
  add_index "Keys", ["Key"], name: "Key_UNIQUE", unique: true, using: :btree

  create_table "Liens", primary_key: "ID", force: true do |t|
    t.integer  "GrantorID",   null: false
    t.datetime "DateIssued",  null: false
    t.float    "Amount",      null: false
    t.datetime "ReleaseDate", null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "Liens", ["GrantorID"], name: "fk_LiensGrantorID", using: :btree

  create_table "ModulesOperations", primary_key: "ID", force: true do |t|
    t.integer  "ModuleID",    null: false
    t.integer  "OperationID", null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "ModulesOperations", ["ModuleID"], name: "fk_ModuleID", using: :btree
  add_index "ModulesOperations", ["OperationID"], name: "fk_OperationID", using: :btree

  create_table "Operations", primary_key: "ID", force: true do |t|
    t.string   "Operation",   limit: 20,  null: false
    t.string   "Description", limit: 100, null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  create_table "Pages", primary_key: "ID", force: true do |t|
    t.string "Name",        limit: 45, null: false
    t.string "DateCreated", limit: 45, null: false
    t.string "DateUpdated", limit: 45, null: false
  end

  create_table "PagesContent", primary_key: "ID", force: true do |t|
    t.integer  "PageID",                 null: false
    t.string   "Title",       limit: 30, null: false
    t.text     "Body",                   null: false
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  add_index "PagesContent", ["PageID"], name: "fk_PageID", using: :btree

  create_table "PeriodType", primary_key: "ID", force: true do |t|
    t.string   "Type",        limit: 10, null: false
    t.datetime "DateCreated",            null: false
    t.datetime "DateUpdated",            null: false
  end

  create_table "Plaintiffs", primary_key: "ID", force: true do |t|
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "MiddleName",    limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 20,  null: false
    t.string   "City",          limit: 100, null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 20,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  add_index "Plaintiffs", ["City"], name: "fk_PlaintiffsCityID", using: :btree
  add_index "Plaintiffs", ["State"], name: "fk_PlaintiffsStateID", using: :btree

  create_table "ReviewQuestions", primary_key: "ID", force: true do |t|
    t.integer  "ParentID"
    t.string   "Description", limit: 50, null: false
    t.datetime "DateCreated",            null: false
    t.string   "DateUpdated", limit: 45, null: false
  end

  create_table "Reviews", primary_key: "ID", force: true do |t|
    t.integer  "UserID",                              null: false
    t.binary   "IsVisible",                 limit: 1, null: false
    t.binary   "IsApproved",                limit: 1, null: false
    t.text     "MLAndJudgments",                      null: false
    t.text     "OtherPublicThirdPartyInfo",           null: false
    t.datetime "DateCreated",                         null: false
    t.datetime "DateUpdated",                         null: false
  end

  add_index "Reviews", ["UserID"], name: "fk_ReviewsUserID", using: :btree

  create_table "RolesModules", primary_key: "ID", force: true do |t|
    t.integer  "RoleID",            null: false
    t.integer  "ModuleOperationID", null: false
    t.datetime "DateCreated",       null: false
    t.datetime "DateUpdated",       null: false
  end

  add_index "RolesModules", ["ModuleOperationID"], name: "fk_ModuleOperationID", using: :btree
  add_index "RolesModules", ["RoleID"], name: "fk_RoleID", using: :btree

  create_table "SearchContacts", primary_key: "ID", force: true do |t|
    t.integer  "SearchID",                 null: false
    t.string   "ContactNumber", limit: 20, null: false
    t.datetime "DateCreated",              null: false
    t.datetime "DateUpdated",              null: false
  end

  create_table "SearchDetails", primary_key: "ID", force: true do |t|
    t.string   "FirstName",     limit: 20,  null: false
    t.string   "MiddleName",    limit: 20,  null: false
    t.string   "LastName",      limit: 20,  null: false
    t.string   "StreetAddress", limit: 20,  null: false
    t.string   "City",          limit: 100, null: false
    t.string   "State",         limit: 20,  null: false
    t.string   "ZipCode",       limit: 20,  null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  create_table "SearchReports", primary_key: "ID", force: true do |t|
    t.integer  "SearchID",                  null: false
    t.integer  "UserID",                    null: false
    t.integer  "SearchCount",               null: false
    t.binary   "FeedbackRequest", limit: 1, null: false
    t.datetime "DateCreated",               null: false
    t.datetime "DateUpdated",               null: false
  end

  add_index "SearchReports", ["SearchID"], name: "fk_SearchID", using: :btree
  add_index "SearchReports", ["UserID"], name: "fk_SearchUserID", using: :btree

  create_table "SiteAccessReports", primary_key: "ID", force: true do |t|
    t.integer  "UserID",         null: false
    t.datetime "LoginDateTime",  null: false
    t.datetime "LogOutDateTime", null: false
  end

  create_table "SiteModules", primary_key: "ID", force: true do |t|
    t.string   "Module",      limit: 20,  null: false
    t.string   "Description", limit: 100, null: false
    t.datetime "DateCreated",             null: false
    t.string   "DateUpdated", limit: 45,  null: false
  end

  create_table "States", primary_key: "ID", force: true do |t|
    t.string "Name",        limit: 45, null: false
    t.string "DateCreated", limit: 45, null: false
    t.string "DateUpdated", limit: 45, null: false
  end

  create_table "SubscribedUsers", primary_key: "ID", force: true do |t|
    t.string   "UserName",          limit: 20,  null: false
    t.string   "Password",          limit: 100, null: false
    t.string   "Salt",              limit: 45,  null: false
    t.string   "FirstName",         limit: 20,  null: false
    t.string   "MiddleName",        limit: 20
    t.string   "LastName",          limit: 20,  null: false
    t.string   "EmailID",           limit: 50,  null: false
    t.string   "CompanyName",       limit: 20,  null: false
    t.string   "IncorporationType", limit: 20,  null: false
    t.string   "ContactNumber",     limit: 20,  null: false
    t.string   "LicenseNumber",     limit: 20,  null: false
    t.string   "AuthCodeUsed",      limit: 45
    t.binary   "IsEnabled",         limit: 1,   null: false
    t.binary   "IsActivated",       limit: 1,   null: false
    t.binary   "IsApproved",        limit: 1,   null: false
    t.binary   "IsSubscribed",      limit: 1,   null: false
    t.datetime "DateCreated",                   null: false
    t.datetime "DateUpdated",                   null: false
  end

  add_index "SubscribedUsers", ["ID"], name: "ID_UNIQUE", unique: true, using: :btree
  add_index "SubscribedUsers", ["IncorporationType"], name: "fk_IncorporationTypeID", using: :btree
  add_index "SubscribedUsers", ["UserName"], name: "SubscribedUsercol_UNIQUE", unique: true, using: :btree

  create_table "SubscriptionPlans", primary_key: "ID", force: true do |t|
    t.string   "Title",        limit: 20,  null: false
    t.string   "Description",  limit: 100, null: false
    t.integer  "Period",                   null: false
    t.integer  "PeriodTypeID",             null: false
    t.binary   "isEnabled",    limit: 1,   null: false
    t.datetime "DateCreated",              null: false
    t.datetime "DateUpdated",              null: false
  end

  add_index "SubscriptionPlans", ["PeriodTypeID"], name: "fk_PeriodTypeID", using: :btree

  create_table "UserAddressDetails", primary_key: "ID", force: true do |t|
    t.integer  "UserID",                  null: false
    t.string   "AddressType", limit: 20,  null: false
    t.string   "Address",     limit: 100, null: false
    t.string   "City",        limit: 100, null: false
    t.string   "State",       limit: 20,  null: false
    t.string   "ZIPCode",     limit: 20,  null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  add_index "UserAddressDetails", ["AddressType"], name: "fk_UserAddressTypeID", using: :btree
  add_index "UserAddressDetails", ["City"], name: "fk_AddressCityID", using: :btree
  add_index "UserAddressDetails", ["ID"], name: "ID_UNIQUE", unique: true, using: :btree
  add_index "UserAddressDetails", ["State"], name: "fk_AddressStateID", using: :btree
  add_index "UserAddressDetails", ["UserID"], name: "fk_AddressUseriD", using: :btree

  create_table "UserAuthorization", primary_key: "ID", force: true do |t|
    t.integer  "UserID",      null: false
    t.integer  "RoleID",      null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "UserAuthorization", ["RoleID"], name: "fk_AuthRoleID", using: :btree
  add_index "UserAuthorization", ["UserID"], name: "fk_AuthUserID", using: :btree

  create_table "UserPaymentDetails", primary_key: "ID", force: true do |t|
    t.string   "UserID",        limit: 100, null: false
    t.string   "PayerID",       limit: 100, null: false
    t.string   "Token",         limit: 100, null: false
    t.string   "TransactionID", limit: 45,  null: false
    t.string   "Message",       limit: 45,  null: false
    t.datetime "DateCreated",               null: false
    t.string   "DateUpdated",   limit: 500, null: false
  end

  add_index "UserPaymentDetails", ["ID"], name: "ID_UNIQUE", unique: true, using: :btree

  create_table "UserRoles", primary_key: "ID", force: true do |t|
    t.string   "Role",        limit: 20,  null: false
    t.string   "Description", limit: 100, null: false
    t.datetime "DateCreated",             null: false
    t.datetime "DateUpdated",             null: false
  end

  create_table "UserSubscriptionPlan", primary_key: "ID", force: true do |t|
    t.integer  "UserID",      null: false
    t.integer  "PlanID",      null: false
    t.datetime "StartDate",   null: false
    t.datetime "EndDate",     null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "UserSubscriptionPlan", ["PlanID"], name: "fk_UserSubscriptionPlanID", using: :btree
  add_index "UserSubscriptionPlan", ["UserID"], name: "fk_UserSubscriptionUserID", using: :btree

  create_table "UserSubscriptionPlanHistory", primary_key: "ID", force: true do |t|
    t.integer  "UserID",      null: false
    t.integer  "PlanID",      null: false
    t.datetime "StartDate",   null: false
    t.datetime "EndDate",     null: false
    t.datetime "DateCreated", null: false
    t.datetime "DateUpdated", null: false
  end

  add_index "UserSubscriptionPlanHistory", ["PlanID"], name: "fk_UserSubscriptionHistoryPlanID", using: :btree
  add_index "UserSubscriptionPlanHistory", ["UserID"], name: "fk_UserSubscriptionHistoryUserID", using: :btree

  create_table "paypal_interfaces", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paypal_workerrs", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paypal_workers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
