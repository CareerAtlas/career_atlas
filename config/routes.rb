Rails.application.routes.draw do

  namespace :api do
    resources :jobs, only: [:index, :show, :create]
    resources :users, only: [:index, :create]
    resources :companies, only: [:index, :show, :create]
    resources :walkscores, only: [:index]

  end
end
