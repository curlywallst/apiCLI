class CLI

  def call
    menu
  end

  def menu
    input = ""
    while input.downcase != "exit" do
      puts "Type 'categories' to select a category of drinks, ....., or 'exit' to exit."
      input = gets.strip.downcase
      if input == "categories"
        categories = CocktailAPI.getCategories

        Category.all.each.with_index(1) do |value, index|
          puts "#{index}. #{value.name}"
        end
        select_category
      end
    end
  end

  def select_category
    puts "Type the number of the category in which you would like to see drinks"
    input = gets.strip.downcase
    category = Category.all[input.to_i-1].name.gsub(" ","_")
    drinks = Cocktail.find_by_category(category)
    if drinks.length == 0
      CocktailAPI.getDrinksByCategory(category)
      drinks = Cocktail.find_by_category(category)
    end
    Cocktail.find_by_category(category).each.with_index(1) do |value, index|
      puts "#{index}. #{value.name}"
    end
    puts "Type the number of the drink you would like to see or 'list' to see the list again."
    input = gets.strip
    drink = CocktailAPI.getDrinkDetails(drinks[input.to_i-1].drink_id)
    print_drink(drink)
  end

  def print_drink(drink)
    puts ""
    puts "Cocktail Name:  #{drink.name.upcase.colorize(:red)}"
    puts "---------------------------"
    puts "Glass Type: #{drink.glass.colorize(:blue)}"
    puts ""
    puts "Instructions: #{drink.instructions.colorize(:green)}"
    puts ""
    puts "Ingredients:"
    puts ""
    drink.ingredients.each_with_index do |ingredient, index|
      puts "#{drink.measures[index]}#{ingredient}"
    end
    puts ""
  end

end
