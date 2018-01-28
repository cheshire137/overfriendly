module UserHelper
  def platform_options
    valid_options = User::VALID_PLATFORMS.map { |key, label| [label, key] }
    if current_user.platform.blank?
      [['--', '']] + valid_options
    else
      valid_options
    end
  end

  def region_options
    valid_options = User::VALID_REGIONS.map { |key, label| [label, key] }
    if current_user.region.blank?
      [['--', '']] + valid_options
    else
      valid_options
    end
  end

  def role_filter(role, omitted_roles)
    delimiter = ','
    is_checked = !omitted_roles.include?(role)
    check_box_tag('role', role, is_checked, class: 'js-role-filter', data: {
      'url-without' => users_path(omit_role: (omitted_roles + [role]).uniq.join(delimiter)),
      'url-with' => users_path(omit_role: (omitted_roles - [role]).join(delimiter).presence)
    })
  end
end
