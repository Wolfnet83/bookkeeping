Rails.application.routes.draw do
  get 'transactions/index'

  root 'transactions#index'
end
