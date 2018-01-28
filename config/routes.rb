Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  get '/profile/:battletag/:platform/:region' => 'profile#show', as: :profile
  get '/stats/:battletag/:platform/:region' => 'profile#stats', as: :stats

  get '/user/:battletag/:platform/:region' => 'users#show', as: :user
  put '/user' => 'users#update', as: :user_update
  get '/settings' => 'users#settings', as: :settings

  root to: 'home#index'
end
