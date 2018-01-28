Rails.application.routes.draw do

  devise_for :users
	root "dashboards#index"

	get "dashboards/index"
end
