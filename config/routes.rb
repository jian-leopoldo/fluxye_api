Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'auth#login'
      post 'auth/reset_password', to: 'auth#reset_password'
      post 'auth/request_password_recovery', to: 'auth#request_password_recovery'
      post 'auth/logout', to: 'session#logout'
      resources :users
      resources :communities
      resources :community_groups
    end
  end
end
