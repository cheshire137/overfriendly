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

  def hero_bar_width(seconds, total)
    percent = (seconds.to_f / total) * 100
    percent + 2
  end
end
