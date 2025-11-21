class SmsSender
  def self.client
    @client ||= Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )
  end

  def self.send_appointment_reminder(appointment)
    patient = appointment.patient
    return unless patient&.phone.present?

    body = "Recordatorio de cita Dental Bolivia: #{I18n.l(appointment.scheduled_at, format: '%d/%m/%Y %H:%M')} con #{appointment.dentist.name}."

    client.messages.create(
      from: ENV["TWILIO_FROM_NUMBER"],
      to: patient.phone,
      body: body
    )
  end
end
