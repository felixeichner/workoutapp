class MessagesController < ApplicationController
	before_action :authenticate_user!

	def create
		@message = current_user.messages.build(message_params)
		@message.room = current_room
		if @message.save
#			redirect_to "users/#{current_user.id}/exercises?room_id=<%= params[message][:user_id] %>"
			redirect_to user_exercises_path(current_user, room_id: current_room.id)
		end
	end

	private

		def message_params
			params.require(:message).permit(:body, :room)
		end
end