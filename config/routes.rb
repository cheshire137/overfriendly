Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  get '/profile/:battletag/:platform/:region' => 'profile#show', as: :profile
  get '/summary/:battletag/:platform/:region' => 'profile#summary', as: :summary
  get '/stats/:battletag/:platform/:region' => 'profile#stats', as: :stats
  put '/profile/refresh' => 'profile#refresh', as: :profile_refresh

  get '/users' => 'users#index', as: :users
  get '/user/:battletag/:platform/:region' => 'users#show', as: :user
  put '/user' => 'users#update', as: :user_update
  get '/settings' => 'users#settings', as: :settings

  scope defaults: { format: :json }, path: '/api' do
    post '/teams' => 'api/teams#create'
  end

  root to: 'home#index'
end
