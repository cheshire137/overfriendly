Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  get '/profile' => 'user#profile', as: :profile
  get '/stats' => 'user#stats', as: :stats
  get '/friends/:battletag' => 'friends#index', as: :friends
  get '/user/:battletag' => 'user#show', as: :user
  put '/user/:battletag' => 'user#update'
  get '/settings' => 'user#settings', as: :settings

  root to: 'home#index'
end
