Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "pages#home"
  resources :users
  resources :events do
    resources :event_bookings, only: [ :create ]
  end
  resources :event_bookings, only: [ :destroy ]
  resources :shops
end
