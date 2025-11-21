class CreatePatients < ActiveRecord::Migration[8.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.date :birth_date
      t.string :address
      t.text :allergies
      t.text :medications
      t.text :medical_history
      t.text :notes
      t.boolean :privacy_consent
      t.date :data_retention_date
      t.string :profile_access_token

      t.timestamps
    end
  end
end
