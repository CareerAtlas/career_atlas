Rails.application.routes.draw do

  namespace :api do
    resources :jobs, only: [:index, :show, :create]
    resources :users, only: [:index, :create, :destroy]
    resources :companies, only: [:index, :show, :create]
    resources :walkscores, only: [:index]
    resource :authorization, only: [:create, :destroy], controller: :authorization
    resources :saved_jobs, only: [:index, :show], param: :job_key 
  end
end
