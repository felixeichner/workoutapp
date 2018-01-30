Rails.application.routes.draw do

	root "dashboards#index"

	resources :dashboards, only: [:index] do
		collection do
			post :search, to: "dashboards#search"
		end
	end

  devise_for :users
  resources :users do
  	resources :exercises
  end

  resources :friendships, only: [:create, :destroy]
end
