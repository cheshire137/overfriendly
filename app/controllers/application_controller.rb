class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def ensure_user_complete
    return unless signed_in?
    redirect_to settings_path unless current_user.complete?
  end
end
