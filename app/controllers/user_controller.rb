class UserController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def profile
    profile = get_profile
    return head(:failed_dependency) unless profile

    render partial: 'user/profile', layout: false, locals: { profile: profile }
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

  def get_profile
    data = Rails.cache.fetch("profile-data/#{current_user.to_param}", expires_in: 1.hour) do
      api = current_user.overwatch_api
      api.profile
    end
    return unless data

    Profile.new(data)
  end

  def user_params
    params.require(:user).permit(:region, :platform)
  end
end
