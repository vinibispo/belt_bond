Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  get "login", to: "login#new", as: :login
  post "login", to: "login#create"

  get "verify-email", to: "login#verify_email", as: :verify_email

  get "check-inbox", to: "login#check_inbox", as: :check_inbox

  # Defines the root path route ("/")
  # root "posts#index"
end
