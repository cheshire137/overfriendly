class HomeController < ApplicationController
  before_action :redirect_if_signed_in

  def index
  end

  private

  def redirect_if_signed_in
    redirect_to(user_path(current_user)) if signed_in?
  end
end
