class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show mark_paid]

  def show
    qr_payload = @invoice.qr_code_data.presence || default_qr_payload

    qr = RQRCode::QRCode.new(qr_payload)
    @qr_svg = qr.as_svg(
      offset: 0,
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 4,
      standalone: true
    )

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "invoice-#{@invoice.id}",
               template: "invoices/show",
               formats: [:html]
      end
    end
  end

  def mark_paid
    @invoice.update!(status: :paid)
    redirect_to invoice_path(@invoice), notice: "Factura marcada como pagada."
  end

  private

  def set_invoice
    @invoice = Invoice.includes(:patient, :appointment).find(params[:id])
  end

  def default_qr_payload
    "INVOICE|#{@invoice.id}|#{@invoice.amount}|#{@invoice.patient.name}|#{@invoice.appointment.scheduled_at.iso8601}"
  end
end
