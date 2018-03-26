Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :update]

  get 'dashboard/index', :as => 'dashboard'

  resources :transactions
  resources :accounts
  resources :categories
  resources :transfers

  get 'currencies/update_exchange_rates'
  resources :currencies

  resources :category_groups
  resources :reports, only: [:index]

  resources :planned_fees
  get 'planned_fee_templates/create_for_month'
  resources :planned_fee_templates

  get 'reports/top_categories', :as => 'top_categories'
  get 'reports/top_categories_by_year', as: :top_categories_by_year

  root 'dashboard#index'
end
