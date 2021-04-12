Rails.application.routes.draw do
  resources :doctors do
    resources :doctor_appointments, as: 'appointments', path: 'appointments', only: [:index, :show]
  end

  resources :patients do
    resources :appointments
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
