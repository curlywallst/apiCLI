class Cocktail
  attr_accessor :name, :drink_id, :category, :alcoholic, :glass, :instructions, :ingredients, :measures

  @@all = []

  def initialize(name: nil, drink_id: nil, category: nil)
    @name = name
    @drink_id = drink_id
    @category = category
    @ingredients = []
    @measures = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_category(category)
    self.all.select { |drink| drink.category == category}
  end

  def self.find_by_id(id)
    self.all.find { |drink| drink.drink_id == id}
  end
end
