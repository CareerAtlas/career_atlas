Rails.application.routes.draw do

  namespace :api do
    resources :jobs, only: [:index, :show, :create]
  end
end
