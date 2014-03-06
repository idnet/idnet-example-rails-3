IdnetRails::Application.routes.draw do
  root :to => "home#index"
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/:provider/setup", to: "sessions#setup"

  match "/signout" => "sessions#destroy", :as => :signout
  match '/private', to: "home#private_data", as: :private
  match '/site_feeds' => 'activities#site_feeds'
  resources :activities, only: [:index, :create]

  get 'app_requests' => 'app_requests#index', as: :app_requests
  get 'app_requests/callback' => 'app_requests#callback'
  get 'app_requests/delete' => 'app_requests#delete', as: :delete_request

  resources :friend_requests
  match '/callback/event', to: 'home#trace_event'
  match '/checkout', to: 'checkout#index', as: :checkout
  match '/merchant/callback', to: 'checkout#show'
end
