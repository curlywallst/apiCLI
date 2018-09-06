class Cocktail
  attr_accessor :name, :drink_id, :category, :alcoholic, :glass, :instructions, :ingredients, :ingredient, :measures

  @@all = []

  def initialize(name: nil, drink_id: nil, category: nil, glass: nil)
    @name = name
    @drink_id = drink_id
    @category = category
    @glass = glass
    @ingredients = []
    @measures = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_group(group, value)
    if group == "category"
      self.all.select { |drink| drink.category == value}
    elsif group == "glass"
      self.all.select { |drink| drink.glass == value}
    elsif group == "ingredient"
      self.all.select {|drink| drink.ingredient == value}
    elsif group == "alcoholic"
      self.all.select {|drink| drink.alcoholic == value}
    end
  end

  def self.find_by_id(id)
    self.all.find { |drink| drink.drink_id == id}
  end
end
