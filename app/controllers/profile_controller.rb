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

  private

  def overwatch_api
    OverwatchApi.new(battletag: params[:battletag], region: params[:region],
                     platform: params[:platform])
  end

  def get_profile
    cache_key = "profile-data/#{params[:battletag]}/#{params[:region]}/#{params[:platform]}"
    data = Rails.cache.fetch(cache_key, expires_in: 1.week) { overwatch_api.profile }
    return unless data

    Profile.new(data)
  end

  def get_stats
    cache_key = "stats-data/#{params[:battletag]}/#{params[:region]}/#{params[:platform]}"
    data = Rails.cache.fetch(cache_key, expires_in: 1.week) { overwatch_api.stats }
    return unless data

    Stats.new(data)
  end
end
