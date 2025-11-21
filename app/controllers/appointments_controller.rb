class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[edit update destroy generate_invoice create_invoice send_reminder]

  def index
    @dentists = User.role_dentist.order(:name)

    scope = Appointment.includes(:patient, :dentist).order(scheduled_at: :asc)
    if params[:dentist_id].present?
      scope = scope.where(dentist_id: params[:dentist_id])
    end

    @appointments = scope
  end

  def new
    @appointment = Appointment.new
    @patients = Patient.order(:name)
    @dentists = User.role_dentist.order(:name)
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to appointments_path, notice: "Cita creada correctamente."
    else
      @patients = Patient.order(:name)
      @dentists = User.role_dentist.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @patients = Patient.order(:name)
    @dentists = User.role_dentist.order(:name)
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Cita actualizada correctamente."
    else
      @patients = Patient.order(:name)
      @dentists = User.role_dentist.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "Cita eliminada correctamente."
  end

  def generate_invoice
    if @appointment.invoice.present?
      redirect_to invoice_path(@appointment.invoice), notice: "La factura ya existe para esta cita."
    else
      @invoice = Invoice.new(patient: @appointment.patient, appointment: @appointment)
    end
  end

  def create_invoice
    if @appointment.invoice.present?
      redirect_to invoice_path(@appointment.invoice), notice: "La factura ya existe para esta cita."
      return
    end

    amount = invoice_params[:amount].presence || 0

    invoice = Invoice.create!(
      patient: @appointment.patient,
      appointment: @appointment,
      amount: amount,
      payment_method: invoice_params[:payment_method],
      status: :pending,
      qr_code_data: "INVOICE|#{@appointment.id}|#{amount}|#{@appointment.patient.name}"
    )

    redirect_to invoice_path(invoice), notice: "Factura generada correctamente."
  end

  def send_reminder
    AppointmentReminderJob.perform_later(@appointment.id)
    redirect_to appointments_path, notice: "Recordatorio encolado para esta cita."
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:amount, :payment_method)
  end

  def appointment_params
    params.require(:appointment).permit(
      :patient_id,
      :dentist_id,
      :scheduled_at,
      :status,
      :service_type,
      :notes
    )
  end
end
