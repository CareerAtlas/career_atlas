Rails.application.routes.draw do

  namespace :api do
    resources :jobs, only: [:index, :show, :create]
    resources :users, only: [:index, :create, :destroy]
    resources :companies, only: [:index, :show, :create]
    resources :walkscores, only: [:index]
    resources :authorizations, only: [:create, :destroy]

  end
end
