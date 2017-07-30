Rails.application.routes.draw do
  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/"
  post 'auth/login', to: 'authentication#authenticate', as: :login_auth
  post 'signup', to: 'users#create'
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :todos do
      resources :items
    end
  end
end
