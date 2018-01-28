class HomeController < ApplicationController
  before_action :redirect_if_signed_in

  def index
  end

  private

  def redirect_if_signed_in
    if signed_in?
      if current_user.complete?
        redirect_to user_path(current_user, current_user.platform, current_user.region)
      else
        redirect_to settings_path
      end
    end
  end
end
