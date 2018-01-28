class Stats
  attr_reader :username, :competitive_heroes, :quickplay_heroes

  def initialize(data)
    @username = data['username']
    @competitive_heroes = []
    @quickplay_heroes = []

    if stats = data['stats']
      if top_hero_stats = stats['top_heroes']
        if top_hero_stats['competitive']
          @competitive_heroes = top_hero_stats['competitive'].
            map { |hero_data| Hero.new(hero_data) }.
            select { |hero| hero.any_playtime? }
        end

        if top_hero_stats['quickplay']
          @quickplay_heroes = top_hero_stats['quickplay'].
            map { |hero_data| Hero.new(hero_data) }.
            select { |hero| hero.any_playtime? }
        end
      end
    end
  end
end
