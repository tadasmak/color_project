Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    get "colors/complementary", to: "colors#complementary"
    get "colors/triadic", to: "colors#triadic"
    get "colors/tetradic", to: "colors#tetradic"
    get "colors/analogous", to: "colors#analogous"
    get "colors/split_complementary", to: "colors#split_complementary"
  end
end
