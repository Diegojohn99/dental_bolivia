class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  include Pundit::Authorization

  before_action :set_current_attributes
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone role specialty two_factor_enabled])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name phone role specialty two_factor_enabled])
  end

  private

  def set_current_attributes
    Current.user = current_user
    Current.ip_address = request.remote_ip
    Current.user_agent = request.user_agent
  end
end
