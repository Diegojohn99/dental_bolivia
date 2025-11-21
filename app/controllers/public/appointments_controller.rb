module Public
  class AppointmentsController < ApplicationController
    skip_before_action :authenticate_user!

    def confirm
      @appointment = Appointment.find_by(confirmation_token: params[:token])
      if @appointment
        @appointment.update(status: :confirmed)
      end
    end

    def cancel
      @appointment = Appointment.find_by(confirmation_token: params[:token])
      if @appointment
        @appointment.update(status: :cancelled)
      end
    end
  end
end
