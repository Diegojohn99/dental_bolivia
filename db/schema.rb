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

ActiveRecord::Schema[8.1].define(version: 2025_11_20_230119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.string "confirmation_token"
    t.datetime "created_at", null: false
    t.bigint "dentist_id", null: false
    t.text "notes"
    t.bigint "patient_id", null: false
    t.boolean "reminder_1h_sent"
    t.boolean "reminder_24h_sent"
    t.datetime "scheduled_at"
    t.string "service_type"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["dentist_id"], name: "index_appointments_on_dentist_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "audit_logs", force: :cascade do |t|
    t.string "action"
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.integer "record_id"
    t.string "record_type"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal "amount"
    t.bigint "appointment_id", null: false
    t.datetime "created_at", null: false
    t.bigint "patient_id", null: false
    t.string "payment_method"
    t.string "pdf_url"
    t.text "qr_code_data"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_invoices_on_appointment_id"
    t.index ["patient_id"], name: "index_invoices_on_patient_id"
  end

  create_table "medical_records", force: :cascade do |t|
    t.bigint "appointment_id", null: false
    t.datetime "created_at", null: false
    t.bigint "dentist_id", null: false
    t.date "follow_up_date"
    t.text "observations"
    t.bigint "patient_id", null: false
    t.string "procedure"
    t.text "treatment_plan"
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_medical_records_on_appointment_id"
    t.index ["dentist_id"], name: "index_medical_records_on_dentist_id"
    t.index ["patient_id"], name: "index_medical_records_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "address"
    t.text "allergies"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.date "data_retention_date"
    t.string "email"
    t.text "medical_history"
    t.text "medications"
    t.string "name"
    t.text "notes"
    t.string "phone"
    t.boolean "privacy_consent"
    t.string "profile_access_token"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "phone"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role"
    t.string "specialty"
    t.boolean "two_factor_enabled"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "patients"
  add_foreign_key "appointments", "users", column: "dentist_id"
  add_foreign_key "audit_logs", "users"
  add_foreign_key "invoices", "appointments"
  add_foreign_key "invoices", "patients"
  add_foreign_key "medical_records", "appointments"
  add_foreign_key "medical_records", "patients"
  add_foreign_key "medical_records", "users", column: "dentist_id"
end
