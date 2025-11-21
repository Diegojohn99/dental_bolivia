class AuditLogsController < ApplicationController
  before_action :ensure_admin

  def index
    @audit_logs = AuditLog.includes(:user).order(created_at: :desc)

    # Filtros opcionales
    if params[:action_filter].present?
      @audit_logs = @audit_logs.where(action: params[:action_filter])
    end

    if params[:resource_type_filter].present?
      @audit_logs = @audit_logs.where(resource_type: params[:resource_type_filter])
    end

    if params[:date_from].present?
      @audit_logs = @audit_logs.where('created_at >= ?', Date.parse(params[:date_from]))
    end

    if params[:date_to].present?
      @audit_logs = @audit_logs.where('created_at <= ?', Date.parse(params[:date_to]).end_of_day)
    end

    # Aplicar paginación al final
    page = [params[:page].to_i, 1].max
    @audit_logs = @audit_logs.limit(50).offset((page - 1) * 50)
  end

  private

  def ensure_admin
    redirect_to root_path, alert: "Acceso denegado." unless current_user&.role_admin?
  end
end
