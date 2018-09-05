class CLI

  def call
    menu
  end

  def menu
    input = ""
    while input.downcase != "exit" do
      puts ""
      puts "Type 'categories' to select a category of drinks, ....., or 'exit' to exit."
      input = gets.strip.downcase
      if input == "categories"
        CocktailAPI.getCategories if Category.all == []
        print_categories
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
      drinks = CocktailAPI.getDrinksByCategory(category)
    end
    print_drinks_in_category(category)
    while input != "menu"
      puts "Type the number of the drink you would like to see, 'list' to see the list again or 'menu' to return to the main menu."
      puts ""
      input = gets.strip
      if input == 'list'
        print_drinks_in_category(category)
      elsif input.to_i > 0 && input.to_i <= Cocktail.find_by_category(category).length
        if Cocktail.find_by_category(category)[input.to_i-1].ingredients == []
          drink = CocktailAPI.getDrinkDetails(Cocktail.find_by_category(category)[input.to_i-1].drink_id)
        else
          drink = Cocktail.find_by_category(category)[input.to_i-1]
        end
        print_drink(drink)
        puts ""
      elsif input != 'menu'
        puts "Oops, I didn't understand that"        # puts "Type the number of the drink you would like to see, 'list' to see the list again or 'menu' to return to the main menu."
      end
    end
  end

  def print_categories
    puts ""
    Category.all.each.with_index(1) do |value, index|
      puts "#{index}. #{value.name}"
    end
    puts ""
  end

  def print_drinks_in_category(category)
    puts ""
    Cocktail.find_by_category(category).each.with_index(1) do |value, index|
      puts "#{index}. #{value.name}"
    end
    puts ""
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
      puts "#{ingredient} - #{drink.measures[index]}"
    end
    puts ""
  end

end
