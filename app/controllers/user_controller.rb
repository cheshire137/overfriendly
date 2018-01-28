class UserController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def profile
    profile = get_profile
    return head(:failed_dependency) unless profile

    render partial: 'user/profile', layout: false, locals: { profile: profile }
  end

  def stats
    stats = get_stats
    return head(:failed_dependency) unless stats

    render partial: 'user/stats', layout: false, locals: { stats: stats }
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

  def get_stats
    data = Rails.cache.fetch("stats-data/#{current_user.to_param}", expires_in: 1.hour) do
      api = current_user.overwatch_api
      api.stats
    end
    return unless data

    Stats.new(data)
  end

  def user_params
    params.require(:user).permit(:region, :platform)
  end
end
