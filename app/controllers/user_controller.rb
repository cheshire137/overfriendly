class UserController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    current_user.assign_attributes(user_params)

    if current_user.save
      flash[:notice] = 'Updated your platform and region.'
    else
      flash[:alert] = "Couldn't update: #{current_user.errors.full_messages.join(', ')}"
    end

    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:region, :platform)
  end
end
