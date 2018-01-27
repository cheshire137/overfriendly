class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:user]
  before_action :redirect_if_signed_in, only: [:index]

  def index
  end

  def user
  end

  private

  def redirect_if_signed_in
    redirect_to(user_path(current_user)) if signed_in?
  end
end
