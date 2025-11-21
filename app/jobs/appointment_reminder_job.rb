class AppointmentReminderJob < ApplicationJob
  queue_as :default

  def perform(appointment_id)
    appointment = Appointment.includes(:patient, :dentist).find_by(id: appointment_id)
    return unless appointment && appointment.patient

    sent_methods = []

    # Email
    if appointment.patient.email.present?
      AppointmentMailer.reminder_email(appointment.id).deliver_now
      sent_methods << "email"
    end

    # SMS (opcional, solo si hay teléfono)
    if appointment.patient.respond_to?(:phone) && appointment.patient.phone.present?
      SmsSender.send_appointment_reminder(appointment)
      sent_methods << "SMS"
    end

    # Auditoría
    if sent_methods.any?
      AuditService.log(
        action: "reminder_sent",
        resource: appointment,
        details: "Recordatorio enviado vía #{sent_methods.join(' y ')} a #{appointment.patient.name}"
      )
    end
  end
end
