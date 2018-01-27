class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def bnet
    auth = request.env['omniauth.auth']
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_initialize
    user.battletag = auth.info.battletag
    if user.save
      sign_in_and_redirect(user, event: :authentication)
    else
      redirect_to root_path, alert: 'Failed to sign in via Battle.net.'
    end
  end

  def failure
    redirect_to root_path
  end
end
