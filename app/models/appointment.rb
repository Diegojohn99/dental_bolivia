class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :dentist, class_name: "User"
  has_one :invoice, dependent: :destroy
  has_one :medical_record, dependent: :destroy

  enum :status, { scheduled: 0, confirmed: 1, completed: 2, cancelled: 3 }, default: :scheduled

  encrypts :notes

  after_create_commit :schedule_reminder_job, :audit_create
  after_update_commit :audit_update
  after_destroy_commit :audit_destroy

  private

  def schedule_reminder_job
    return unless scheduled_at.present?

    reminder_time = scheduled_at - 3.hours

    # Si la hora de recordatorio ya pasó, no encolamos nada
    return if reminder_time <= Time.current

    AppointmentReminderJob.set(wait_until: reminder_time).perform_later(id)
  end

  def audit_create
    AuditService.log(
      action: "create",
      resource: self,
      user: Current.user,
      details: "Cita creada para #{patient.name} el #{scheduled_at&.strftime('%d/%m/%Y %H:%M')}"
    )
  end

  def audit_update
    if saved_change_to_status?
      AuditService.log(
        action: "status_change",
        resource: self,
        user: Current.user,
        details: "Estado cambiado de #{status_before_last_save} a #{status}"
      )
    else
      AuditService.log(
        action: "update",
        resource: self,
        user: Current.user,
        details: "Cita actualizada"
      )
    end
  end

  def audit_destroy
    AuditService.log(
      action: "destroy",
      resource: self,
      user: Current.user,
      details: "Cita eliminada para #{patient.name}"
    )
  end
end
