IdnetRails::Application.routes.draw do
  root :to => "home#index"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match '/private', to: "home#private_data", as: :private
  get '/activities(/:page)' => "home#activities", as: :activities
  post '/activity' => "home#activity", as: :activity
end
