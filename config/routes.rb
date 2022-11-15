Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :cart, only: [:show]
  post 'cart/add'
  post 'cart/remove'
  post 'cart/make_payment'
  get 'cart/success'
  get 'cart/cancel'
  post 'checkout/create', to: 'checkouts#create'
  resources :users
  resources :events do
    resources :event_bookings, only: [:create]
  end
  resources :event_bookings, only: [:destroy]
  resources :shops
end
