Rails.application.routes.draw do
  resources :doctors do
    resources :doctor_appointments, as: 'appointments', path: 'appointments', only: [:index, :show]
  end
  get 'doctors/:doctor_id/appointments_simple', to: 'doctor_appointments#simple_list'

  resources :patients do
    resources :appointments
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  get 'qr/generate', to: 'qr_codes#generate'
  post 'qr/read', to: 'qr_codes#read'
end
