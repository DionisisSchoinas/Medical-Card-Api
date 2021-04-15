Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :doctors, only: [:index, :create, :show, :update] do
    resources :doctor_appointments, as: 'appointments', path: 'appointments', only: [:index, :show]
  end
  get 'doctors/:doctor_id/appointments_simple', to: 'doctor_appointments#simple_list'
  get 'doctor/appointments', to: 'doctor_appointments#index'
  get 'doctor/appointments/:id', to: 'doctor_appointments#show'
  get 'doctor/appointments_simple', to: 'doctor_appointments#simple_list'

  resources :appointments, only: [:index, :create, :show, :destroy]

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  get 'qr/generate', to: 'qr_codes#generate'
  post 'qr/read', to: 'qr_codes#read'
end
