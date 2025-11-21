class CreateMedicalRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :medical_records do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :dentist, null: false, foreign_key: { to_table: :users }
      t.references :appointment, null: false, foreign_key: true
      t.string :procedure
      t.text :observations
      t.text :treatment_plan
      t.date :follow_up_date

      t.timestamps
    end
  end
end
