class DashboardsController < ApplicationController
	def index
		@athletes = User.order(created_at: :desc)
	end
end