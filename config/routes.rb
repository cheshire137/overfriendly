Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  get '/profile' => 'user#profile', as: :profile
  get '/stats' => 'user#stats', as: :stats

  get '/user/:battletag' => 'user#show', as: :user
  put '/user/:battletag' => 'user#update'

  root to: 'home#index'
end
