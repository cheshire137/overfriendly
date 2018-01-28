module ProfileHelper
  def hero_bar_width(seconds, max, total)
    hero_percent = (seconds.to_f / total) * 100
    max_percent = (max.to_f / total) * 100
    percent = (hero_percent / max_percent) * 100
    percent + 2
  end
end
