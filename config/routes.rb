Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/forecast", to: "forecast#show"
      post '/users', to: "users#create"
      get '/backgrounds', to: "backgrounds#show"
      post '/sessions', to: "sessions#show"
      post '/road_trip', to: "roadtrip#show"
      get '/munchies', to: "munchies#show"
    end
  end
end
