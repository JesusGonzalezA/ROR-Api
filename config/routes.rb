Rails.application.routes.draw do
  resources :movements
  resources :accounts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json' }  do
    namespace :v1 do
      resources :movements
      resources :accounts
      
      # Users
      resources :users, :only => [:create]
      get '/users', to: 'users#login'
      put '/users', to: 'users#update'
      patch '/users', to: 'users#update'
      delete '/users', to: 'users#destroy'
    end
  end
end
