Rails.application.routes.draw do
  root to: 'items#index'
  resources :items
  devise_for :users do
    resources :carts
  	resources :orders
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
