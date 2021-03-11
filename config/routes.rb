Rails.application.routes.draw do
  get 'static_pages/contact'
  get 'static_pages/privacy'
  get 'static_pages/concept'
  get 'static_pages/team'
	root "items#index"
  resources :items
  devise_for :users
	resources :users, only: [:show]

  resources :carts, only: [:show] do
  	put "add/:item_id", to: "carts#create_item", as: :add_to
    put "remove_one/:item_id", to: "carts#remove_one", as: :remove_one
  	put "remove/:item_id", to: "carts#remove", as: :remove_from

  		post "create", to: "carts#create"
  		get 'success', to: 'carts#success'
  		get 'cancel', to: 'carts#cancel'
  end

  # 	resources :carts do
  # 		resources :cart_item_jointables, only: [:destroy, :create]
  # 	end
  # 	resources :orders
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
