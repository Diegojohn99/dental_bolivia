module Public
  class BookingsController < ApplicationController
    skip_before_action :authenticate_user!

    def new
      @patient = Patient.new
      @appointment = Appointment.new
      @dentists = User.role_dentist.order(:name)
    end

    def create
      ActiveRecord::Base.transaction do
        @patient = Patient.find_or_initialize_by(email: booking_params[:patient][:email])
        @patient.assign_attributes(booking_params[:patient])
        @patient.privacy_consent = true
        @patient.save!

        @appointment = @patient.appointments.build(booking_params[:appointment])
        @appointment.status = :scheduled
        @appointment.confirmation_token = SecureRandom.hex(16)
        @appointment.save!
      end

      redirect_to root_path, notice: "Tu cita ha sido solicitada. Te enviaremos la confirmación por correo."
    rescue ActiveRecord::RecordInvalid
      @dentists = User.role_dentist.order(:name)
      render :new, status: :unprocessable_entity
    end

    private

    def booking_params
      params.require(:booking).permit(
        patient: %i[name email phone],
        appointment: %i[dentist_id scheduled_at service_type notes]
      )
    end
  end
end
