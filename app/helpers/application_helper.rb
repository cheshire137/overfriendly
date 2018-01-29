module ApplicationHelper
  def profile_tab_active?
    params[:controller] == 'users' && params[:action] == 'show'
  end

  def settings_tab_active?
    params[:controller] == 'users' && params[:action] == 'settings'
  end

  def users_tab_active?
    params[:controller] == 'users' && params[:action] == 'index'
  end

  def team_tab_active?
    params[:controller] == 'teams' && params[:action] == 'show'
  end
end
