class Hero
  ROLES = %w[dps hitscan flanker healer tank off_tank defense].freeze

  attr_reader :name, :playtime, :url

  def self.normalize_roles(role_str)
    roles = role_str.downcase.split('/')
    roles = roles.map do |role|
      if role == 'dps'
        'DPS'
      else
        role.humanize
      end
    end
    roles.join('/')
  end

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

  def self.humanize_role(role)
    case role.to_sym
    when :dps then 'DPS'
    when :off_tank then 'Off-tank'
    else
      role.to_s.humanize
    end
  end

  def role
    case to_param
    when 'mercy'      then :healer
    when 'zenyatta'   then :healer
    when 'ana'        then :healer
    when 'symmetra'   then :defense
    when 'mei'        then :defense
    when 'soldier-76' then :hitscan
    when 'widowmaker' then :hitscan
    when 'hanzo'      then :defense
    when 'mccree'     then :hitscan
    when 'pharah'     then :dps
    when 'doomfist'   then :dps
    when 'tracer'     then :flanker
    when 'lucio'      then :healer
    when 'moira'      then :healer
    when 'winston'    then :tank
    when 'dva'        then :off_tank
    when 'torbjorn'   then :defense
    when 'bastion'    then :defense
    when 'junkrat'    then :dps
    when 'reaper'     then :dps
    when 'sombra'     then :dps
    when 'genji'      then :flanker
    when 'zarya'      then :off_tank
    when 'roadhog'    then :off_tank
    when 'orisa'      then :tank
    when 'reinhardt'  then :tank
    end
  end

  def to_param
    @to_param ||= I18n.transliterate(name.gsub(/[\.:]/, '')).downcase.gsub(/\s/, '-')
  end

  def to_s
    name
  end
end
