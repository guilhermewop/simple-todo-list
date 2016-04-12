require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # after_action :verify_authorized

  layout :layout_by_controller

  protected

  def layout_by_controller
    devise_controller? ? 'login' : 'application'
  end
end
