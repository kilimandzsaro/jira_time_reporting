class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  # To permit new custom attributes to be verified as attributes permitted by the form
  def configure_permitted_paramenters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, "password, "password_confirmation)}
  end
end
