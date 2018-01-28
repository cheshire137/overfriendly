class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def ensure_user_complete
    return unless signed_in?
    redirect_to settings_path unless current_user.complete?
  end

  def current_page
    if params[:page].present?
      params[:page].to_i
    else
      1
    end
  end

  def require_api_user
  end
end
