require 'will_paginate/array'

class DashboardsController < ApplicationController
	def index
		@athletes = User.search_by_name(params[:search_name]).paginate(:page => params[:page])
	end

	def search
		unless user_signed_in?
			flash.now[:danger] = "Please sign up or log in first"
			render :index
		else
			redirect_to controller: 'dashboards', action: 'index', search_name: params[:search_name]
		end
	end
end