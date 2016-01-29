Rails.application.routes.draw do
  devise_for :users
  get 'dashboard/index', :as => 'dashboard'

  resources :transactions
  resources :accounts
  resources :categories

  root 'dashboard#index'
end
