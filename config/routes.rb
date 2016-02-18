Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :update]

  get 'dashboard/index', :as => 'dashboard'

  resources :transactions
  resources :accounts
  resources :categories
  resources :transfers

  root 'dashboard#index'
end
