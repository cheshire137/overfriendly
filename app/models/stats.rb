class Stats
  attr_reader :username, :competitive_heroes, :quickplay_heroes,
              :total_competitive_seconds, :total_quickplay_seconds,
              :max_competitive_seconds, :max_quickplay_seconds

  def initialize(data)
    @username = data['username']
    @competitive_heroes = []
    @quickplay_heroes = []
    @total_competitive_seconds = 0
    @total_quickplay_seconds = 0
    @max_competitive_seconds = 0
    @max_quickplay_seconds = 0

    if stats = data['stats']
      if top_hero_stats = stats['top_heroes']
        if top_hero_stats['competitive']
          @competitive_heroes = top_hero_stats['competitive'].
            map { |hero_data| Hero.new(hero_data) }.
            select { |hero| hero.any_playtime? }

          @competitive_heroes.each do |hero|
            @total_competitive_seconds += hero.seconds_played
            if hero.seconds_played > @max_competitive_seconds
              @max_competitive_seconds = hero.seconds_played
            end
          end
        end

        if top_hero_stats['quickplay']
          @quickplay_heroes = top_hero_stats['quickplay'].
            map { |hero_data| Hero.new(hero_data) }.
            select { |hero| hero.any_playtime? }

          @quickplay_heroes.each do |hero|
            @total_quickplay_seconds += hero.seconds_played
            if hero.seconds_played > @max_quickplay_seconds
              @max_quickplay_seconds = hero.seconds_played
            end
          end
        end
      end
    end
  end
end
