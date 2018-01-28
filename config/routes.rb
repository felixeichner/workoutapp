Rails.application.routes.draw do

	root "dashboards#index"

	get "dashboards/index"
end
