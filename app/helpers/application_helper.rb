module ApplicationHelper

	def active(controller)
		"active" if params[:controller] == controller
	end

	def exercise_form_button_text
		params[:action] == 'new' ? "Create Workout" : "Update Workout"
	end
end
