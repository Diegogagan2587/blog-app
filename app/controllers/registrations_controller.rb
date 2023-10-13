# Create registration controller to override devise default behaviour
class RegistrationsController < Devise::RegistrationsController
  # we need to permig name and bio params
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio])
  end
end
