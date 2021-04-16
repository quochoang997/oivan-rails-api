Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :tests
      resources :users
      resources :assessments, only: [:index, :create, :show]

      post "login" => "authentication#login"
    end
  end
end
