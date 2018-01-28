class Hero
  attr_reader :name, :playtime, :url

  def initialize(data)
    @name = data['hero']
    @playtime = data['played']
    @url = data['img']
  end

  def any_playtime?
    playtime && playtime != '--'
  end

  def seconds_played
    @seconds_played ||= if any_playtime?
      number, unit = playtime.split(' ')
      number = number.to_i
      unit = unit.sub(/s$/, '') if unit.ends_with?('s')

      if unit == 'second'
        number
      elsif unit == 'minute'
        number * 60
      else
        number * 60 * 60
      end
    else
      0
    end
  end

  def to_param
    @to_param ||= I18n.transliterate(name.gsub(/\./, '')).downcase.gsub(/\s:/, '-')
  end

  def to_s
    name
  end
end
