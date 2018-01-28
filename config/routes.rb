Rails.application.routes.draw do

	root "dashboards#home"

	get "dashboards/home"
end
