class CreateAppointments < ActiveRecord::Migration[8.1]
  def change
    create_table :appointments do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :dentist, null: false, foreign_key: { to_table: :users }
      t.datetime :scheduled_at
      t.integer :status
      t.string :service_type
      t.text :notes
      t.boolean :reminder_24h_sent
      t.boolean :reminder_1h_sent
      t.string :confirmation_token

      t.timestamps
    end
  end
end
