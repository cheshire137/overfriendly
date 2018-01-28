module ApplicationHelper
  def profile_tab_active?
    params[:controller] == 'users' && params[:action] == 'show'
  end

  def settings_tab_active?
    params[:controller] == 'users' && params[:action] == 'settings'
  end

  def friends_tab_active?
    params[:controller] == 'friends' && params[:action] == 'index'
  end
end
