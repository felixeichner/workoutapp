class FriendshipsController < ApplicationController
	before_action :authenticate_user!

	def create
		friend = User.find(params[:friend_id])
		current_user.friendships.create(friendship_params) unless current_user.follows_or_same?(friend)
		redirect_to root_path
	end

	def destroy
	end

	private

		def friendship_params
			params.permit(:friend_id)
		end
end