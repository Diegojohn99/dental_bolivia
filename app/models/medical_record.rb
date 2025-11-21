class MedicalRecord < ApplicationRecord
  belongs_to :patient
  belongs_to :dentist, class_name: "User"
  belongs_to :appointment

  encrypts :observations, :treatment_plan
end
