class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_complete, only: [:show]

  def show
    @battletag = User.battletag_from_param(params[:battletag])
    @platform = params[:platform]
    @region = params[:region]
  end

  def settings
  end

  def update
    current_user.assign_attributes(user_params)

    if current_user.save
      flash[:notice] = 'Updated your platform and region.'
    else
      flash[:alert] = "Couldn't update: #{current_user.errors.full_messages.join(', ')}"
    end

    redirect_to user_path(current_user, current_user.platform, current_user.region)
  end

  private

  def ensure_user_complete
    redirect_to settings_path unless current_user.complete?
  end

  def user_params
    params.require(:user).permit(:region, :platform)
  end
end
