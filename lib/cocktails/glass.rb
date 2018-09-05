class Glass
  attr_accessor :name

  @@all = []

  def initialize(name: nil)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end
end
