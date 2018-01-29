class DashboardsController < ApplicationController
	def index
		@athletes = User.paginate(:page => params[:page]).order(created_at: :desc)
	end
end