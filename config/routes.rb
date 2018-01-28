Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  get '/profile/:battletag/:platform/:region' => 'profile#show', as: :profile
  get '/stats/:battletag/:platform/:region' => 'profile#stats', as: :stats

  get '/friends/:battletag/:platform/:region' => 'friends#index', as: :friends

  get '/user/:battletag/:platform/:region' => 'user#show', as: :user
  put '/user' => 'user#update', as: :user_update
  get '/settings' => 'user#settings', as: :settings

  root to: 'home#index'
end
