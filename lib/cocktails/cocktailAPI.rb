class CocktailAPI
  def self.getGroup(group, group_name)
    url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?#{group_name[0].downcase}=list"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    group_members = JSON.parse(response)["drinks"].each do |c|
      group.new(name: c["str#{group_name}"]) if c["str#{group_name}"] != nil
    end
  end

  def self.getDrinksByGroup(group, group_type)
    url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?#{group[0]}=#{group_type}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    drinks = JSON.parse(response)["drinks"]
    drinks.each do |d|
      cocktail = Cocktail.new(name: d["strDrink"], drink_id: d["idDrink"])
      cocktail.send("#{group}=", group_type)
    end
  end

  def self.getDrinkDetails(id)
    url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    drink_details = JSON.parse(response)
    drink = Cocktail.find_by_id(drink_details["drinks"][0]["idDrink"])
    drink.alcoholic = drink_details["drinks"][0]["strAlcoholic"]
    drink.glass = drink_details["drinks"][0]["strGlass"]
    drink.instructions = drink_details["drinks"][0]["strInstructions"]
    drink_details["drinks"][0].keys.each do |i|
      drink.ingredients << drink_details["drinks"][0][i] if (i.include? "Ingredient") && drink_details["drinks"][0][i] != "" && drink_details["drinks"][0][i] != " " && drink_details["drinks"][0][i] != nil
      drink.measures << drink_details["drinks"][0][i].gsub("\n", "") if (i.include? "Measure") && drink_details["drinks"][0][i] != "" && drink_details["drinks"][0][i] != " " && drink_details["drinks"][0][i] != nil
    end
    drink
  end
end
