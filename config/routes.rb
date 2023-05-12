Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'auth#login'
      post 'auth/recover_password', to: 'auth#recover_password'
      post 'auth/logout', to: 'session#logout'
      resources :users
    end
  end
end
