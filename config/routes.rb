Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root :to => 'endpoints#index'

  resources :endpoints
  match ':path' => 'catchall#index', via: [:get, :head, :post, :patch, :put, :delete]
end
