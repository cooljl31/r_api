Rails.application.routes.draw do
  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/"
  post 'auth/login', to: 'authentication#authenticate', as: :login_auth
  post 'signup', to: 'users#create'
  resources :todos do
    resources :items
  end
end
