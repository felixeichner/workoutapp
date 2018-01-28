module ApplicationHelper

	def active(controller)
		"active" if params[:controller] == controller
	end
end
