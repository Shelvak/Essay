Rails.application.routes.draw do
  resources :clients do
    resources :essays
  end
  resources :shifts
  resources :essays

  get '/reports/samples', to: 'reports#samples'
  delete '/users/quit', to: 'custom_session#quit'

  devise_for :users, path_prefix: 'selfservice'

  resources :users do
    resources :shifts, :essays
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  root to: 'essays#index'
end
