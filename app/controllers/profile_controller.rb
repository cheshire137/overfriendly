class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    profile = get_profile
    return head(:failed_dependency) unless profile

    render partial: 'profile/show', layout: false, locals: { profile: profile }
  end

  def stats
    stats = get_stats
    return head(:failed_dependency) unless stats

    render partial: 'profile/stats', layout: false, locals: { stats: stats }
  end

  def summary
    profile = get_profile
    return head(:failed_dependency) unless profile

    stats = get_stats
    return head(:failed_dependency) unless stats

    render partial: 'profile/summary', layout: false,
           locals: { profile: profile, stats: stats }
  end

  def refresh
    args = [current_user.battletag, current_user.region, current_user.platform]
    key1 = profile_cache_key(*args)
    key2 = stats_cache_key(*args)
    Rails.cache.delete(key1)
    Rails.cache.delete(key2)
    redirect_to user_path(current_user, current_user.platform, current_user.region),
      notice: 'Getting your latest profile data.'
  end

  private

  def overwatch_api
    OverwatchApi.new(battletag: params[:battletag], region: params[:region],
                     platform: params[:platform])
  end

  def get_profile
    cache_key = profile_cache_key(params[:battletag], params[:region], params[:platform])
    data = Rails.cache.fetch(cache_key, expires_in: 1.week) { overwatch_api.profile }
    return unless data

    Profile.new(data)
  end

  def get_stats
    cache_key = stats_cache_key(params[:battletag], params[:region], params[:platform])
    data = Rails.cache.fetch(cache_key, expires_in: 1.week) { overwatch_api.stats }
    return unless data

    Stats.new(data)
  end

  def profile_cache_key(battletag, region, platform)
    "profile-data/#{battletag}/#{region}/#{platform}"
  end

  def stats_cache_key(battletag, region, platform)
    "stats-data/#{battletag}/#{region}/#{platform}"
  end
end
