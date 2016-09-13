Rails.application.routes.draw do
  resources :shifts
  resources :essays

  get '/reports/samples', to: 'reports#samples'
  delete '/users/quit', to: 'custom_session#quit'

  devise_for :users

  resources :users do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  root to: 'essays#index'
end
