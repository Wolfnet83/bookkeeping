Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :update]

  get 'dashboard/index', :as => 'dashboard'

  resources :transactions
  resources :accounts
  resources :categories
  resources :transfers
  resources :currencies
  resources :category_groups

  root 'dashboard#index'
end
