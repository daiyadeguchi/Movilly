Rails.application.routes.draw do
  resources :movies
  root "landing#index"
  get "/movies", to: "movies#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
