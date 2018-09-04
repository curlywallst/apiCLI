class Cocktail
  attr_accessor :name, :drink_id

  @@all = []

  def initialize(name: nil, drink_id: nil)
    @name = name
    @drink_id = drink_id
    @@all << self
  end

  def self.all
    @@all
  end
end
