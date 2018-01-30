class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	  end

	private

		def current_room
			@room ||= Room.find(session[:current_room]) if session[:current_room]
		end

		helper_method :current_room
end
