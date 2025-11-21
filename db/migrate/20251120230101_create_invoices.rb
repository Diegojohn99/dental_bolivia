class CreateInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :invoices do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :appointment, null: false, foreign_key: true
      t.decimal :amount
      t.string :payment_method
      t.text :qr_code_data
      t.integer :status
      t.string :pdf_url

      t.timestamps
    end
  end
end
