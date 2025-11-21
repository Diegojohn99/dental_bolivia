class AppointmentMailer < ApplicationMailer
  default from: ENV.fetch("DEFAULT_FROM_EMAIL", "no-reply@dental-bolivia.test")

  def reminder_email(appointment_id)
    @appointment = Appointment.includes(:patient, :dentist).find(appointment_id)
    @patient = @appointment.patient

    mail(
      to: @patient.email,
      subject: "Recordatorio de cita dental - Dental Bolivia"
    )
  end
end
