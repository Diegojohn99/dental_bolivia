class Patient < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :medical_records, dependent: :destroy
  has_many :invoices, dependent: :destroy

  encrypts :allergies, :medications, :medical_history, :notes

  before_save :set_data_retention_date

  validates :name, presence: true
  validates :email, presence: true

  private

  def set_data_retention_date
    self.data_retention_date ||= 5.years.from_now.to_date
  end
end
