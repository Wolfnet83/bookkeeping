Rails.application.routes.draw do
  get 'dashboard/index', :as => 'dashboard'

  get 'transactions/index', :as => 'transactions'

  resources :accounts
  resources :categories

  root 'dashboard#index'
end
