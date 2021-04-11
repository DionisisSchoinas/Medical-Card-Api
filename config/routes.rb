Rails.application.routes.draw do
  resources :doctors

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
