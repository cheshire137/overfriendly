class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :ensure_user_complete, only: [:show]

  def index
    @omitted_roles = (params[:omit_role].presence || '').split(',')
    @users = User.order_by_battletag.paginate(page: current_page, per_page: 100)
  end

  def show
    @battletag = User.battletag_from_param(params[:battletag])
    @platform = params[:platform]
    @region = params[:region]
    @user = User.where(battletag: @battletag, platform: @platform, region: @region).first
    @teams = if @user
      @user.teams.order('id DESC').paginate(page: current_page, per_page: 5)
    end
  end

  def settings
  end

  def update
    current_user.assign_attributes(user_params)

    if current_user.save
      flash[:notice] = 'Updated your platform and region.'
      redirect_to user_path(current_user, current_user.platform, current_user.region)
    else
      flash[:alert] = "Couldn't update: #{current_user.errors.full_messages.join(', ')}"
      redirect_to settings_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:region, :platform)
  end
end
