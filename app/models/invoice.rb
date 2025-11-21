class Invoice < ApplicationRecord
  belongs_to :patient
  belongs_to :appointment

  enum :status, { pending: 0, paid: 1, cancelled: 2 }, default: :pending

  after_create_commit :audit_create
  after_update_commit :audit_update

  private

  def audit_create
    AuditService.log(
      action: "create",
      resource: self,
      user: Current.user,
      details: "Factura generada por Bs #{amount} para #{patient.name}"
    )
  end

  def audit_update
    if saved_change_to_status?
      AuditService.log(
        action: "status_change",
        resource: self,
        user: Current.user,
        details: "Factura marcada como #{status}"
      )
    else
      AuditService.log(
        action: "update",
        resource: self,
        user: Current.user,
        details: "Factura actualizada"
      )
    end
  end
end
