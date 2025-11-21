Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :appointments do
    member do
      get :generate_invoice
      post :create_invoice
      post :send_reminder
    end
  end

  get "/public/booking", to: "public/bookings#new"

  get "/appointments/confirm/:token", to: "public/appointments#confirm", as: :public_appointment_confirm
  get "/appointments/cancel/:token", to: "public/appointments#cancel", as: :public_appointment_cancel

  resources :invoices, only: [:show] do
    member do
      patch :mark_paid
    end
  end

  resources :audit_logs, only: [:index]

  # Rutas de privacidad
  get "/privacy", to: "privacy#policy", as: :privacy_policy
  get "/privacy/data-request", to: "privacy#data_request", as: :privacy_data_request
  post "/privacy/data-request", to: "privacy#submit_data_request", as: :privacy_submit_data_request

  # Rutas de páginas públicas
  get "/about", to: "pages#about", as: :about
  get "/services", to: "pages#services", as: :services
  get "/contact", to: "pages#contact", as: :contact
  post "/contact", to: "pages#contact_submit", as: :contact_submit
  post "/newsletter", to: "pages#newsletter_signup", as: :newsletter_signup

  namespace :public do
    resource :booking, only: %i[new create]
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "home#index"
end
