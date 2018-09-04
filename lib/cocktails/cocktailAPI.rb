class CocktailAPI
  def self.getCategories
    url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    categories = JSON.parse(response)["drinks"].each do |c|
      Category.new(name: c["strCategory"])
    end
  end

  def self.getDrinksByCategory(category)
    url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=#{category}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    drinks = JSON.parse(response)["drinks"]
    drinks.each do |d|
      cocktail = Cocktail.new(name: d["strDrink"], drink_id: d["idDrink"])
    end
  end

  def self.getDrinkDetails(id)
    url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    drink = JSON.parse(response)
    binding.pry
  end
end
