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

ActiveRecord::Schema.define(version: 2021_08_30_170714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bank_accounts", force: :cascade do |t|
    t.string "name"
    t.string "account_number"
    t.float "balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
  end

  create_table "group_expense_memberships", force: :cascade do |t|
    t.bigint "group_expense_id"
    t.bigint "borrower_id"
    t.bigint "lenter_id"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "settled"
    t.index ["borrower_id"], name: "index_group_expense_memberships_on_borrower_id"
    t.index ["group_expense_id"], name: "index_group_expense_memberships_on_group_expense_id"
    t.index ["lenter_id"], name: "index_group_expense_memberships_on_lenter_id"
  end

  create_table "group_expenses", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.float "expense"
    t.boolean "equal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "percent"
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_group_expenses_on_creator_id"
    t.index ["group_id"], name: "index_group_expenses_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_groups_on_creator_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "amount"
    t.boolean "active"
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "transfer_to_type"
    t.bigint "transfer_to_id"
    t.string "transfer_from_type"
    t.bigint "transfer_from_id"
    t.float "amount"
    t.string "type"
    t.date "date_performed"
    t.integer "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "from_wallet"
    t.boolean "to_wallet"
    t.index ["transfer_from_type", "transfer_from_id"], name: "index_transactions_on_transfer_from"
    t.index ["transfer_to_type", "transfer_to_id"], name: "index_transactions_on_transfer_to"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.float "balance"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "amount_borrowed"
    t.float "amount_lent"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "bank_accounts", "users"
  add_foreign_key "group_expense_memberships", "group_expenses"
  add_foreign_key "group_expense_memberships", "users", column: "borrower_id"
  add_foreign_key "group_expense_memberships", "users", column: "lenter_id"
  add_foreign_key "group_expenses", "groups"
  add_foreign_key "group_expenses", "users", column: "creator_id"
  add_foreign_key "groups", "users", column: "creator_id"
  add_foreign_key "transactions", "users"
  add_foreign_key "wallets", "users"
end
