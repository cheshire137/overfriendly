module ProfileHelper
  def hero_bar_width(seconds, max, total)
    percent = (seconds.to_f / total) * 100
    max_percent = (max.to_f / total) * 100
    (percent / max_percent) * 100
  end
end
