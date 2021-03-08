Rails.application.routes.draw do
	root "items#index"
  resources :items
  devise_for :users

  resources :users do
  	resources :carts do
  		resources :cart_item_jointables, only: [:destroy]
  	end
  	resources :orders
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
