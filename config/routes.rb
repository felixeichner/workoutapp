Rails.application.routes.draw do

	root "dashboards#index"

	get "dashboards/index"

  devise_for :users
  resources :users do
  	resources :exercises
  end
end
