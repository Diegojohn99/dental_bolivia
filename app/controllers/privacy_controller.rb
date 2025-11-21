class PrivacyController < ApplicationController
  skip_before_action :authenticate_user!

  def policy
    # Página pública de política de privacidad
  end

  def data_request
    # Formulario para solicitar eliminación de datos
  end

  def submit_data_request
    @email = params[:email]
    @request_type = params[:request_type]
    @reason = params[:reason]

    if @email.blank?
      flash[:alert] = "El email es requerido."
      render :data_request and return
    end

    # Buscar paciente por email
    patient = Patient.find_by(email: @email)
    
    if patient.nil?
      flash[:alert] = "No encontramos registros asociados a este email."
      render :data_request and return
    end

    # Registrar la solicitud en auditoría
    AuditService.log(
      action: "data_request",
      resource: patient,
      details: "Solicitud de #{@request_type}: #{@reason}"
    )

    # En un sistema real, aquí enviarías un email al administrador
    # o crearías un ticket en un sistema de tickets

    flash[:notice] = "Tu solicitud ha sido recibida. Nos pondremos en contacto contigo en un plazo de 30 días."
    redirect_to privacy_policy_path
  end
end
