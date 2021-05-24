Rails.application.routes.draw do
  resources :movements
  resources :accounts
  resources :users
  resources :movimientos
  resources :cuenta
  resources :usuarios
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json' }  do
    namespace :v1 do
      resources :usuarios
      resources :cuenta
    end
  end
end
