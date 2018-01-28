class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

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
    return head(:unauthorized) unless request.headers['Authorization'].present?

    type, battletag, token = request.headers['Authorization'].split(' ')
    return head(:bad_request) unless type.downcase == 'token'

    head(:forbidden) unless User.has_api_access?(battletag, token)
  end
end
