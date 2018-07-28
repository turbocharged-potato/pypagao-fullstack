# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def ensure_params_fields(fields)
    all_present = fields.reduce(true) do |acc, field|
      params[field].present? && acc
    end
    unless all_present
      render_error('Missing parameter', :unprocessable_entity)
      return
    end
    true
  end

  def render_error(message)
    @message = message
  end
end
