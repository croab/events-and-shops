Rails.application.routes.draw do
  get 'shops/index'
  get 'shops/show'
  get 'shops/new'
  get 'shops/create'
  get 'shops/edit'
  get 'shops/update'
  get 'shops/destroy'
  devise_for :users
  root to: "pages#home"
  resources :users
  resources :events do
    resources :event_bookings, only: [ :create ]
  end
  resources :event_bookings, only: [ :destroy ]
  resources :shops
end
