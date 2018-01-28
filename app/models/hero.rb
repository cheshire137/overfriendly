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

  def to_s
    name
  end
end
