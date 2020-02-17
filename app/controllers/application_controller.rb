# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :deny_access

  include Pundit
  include Pagy::Backend

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
  end

  def deny_access
    render status: :forbidden, plain: 'You shall not pass!'
  end

  def after_sign_in_path_for(_)
    tasks_path
  end

  def after_sign_out_path_for(_)
    root_path
  end
end
