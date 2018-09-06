class CLI

  def call
    menu
  end

  def menu
    input = ""
    while input.downcase != "exit" do
      puts ""
      puts "Type 'category' to select by a category of drinks, 'glass' to select by a type of glass, 'ingredient' to select by an ingredient, 'alcoholic' to select whether or not it contains alcohol or 'exit' to exit."
      puts ""
      input = gets.strip.downcase
      if input == "category"
        CocktailAPI.getCategories if Category.all == []
        print_selection(Category.all)
        select_from_group("category", Category.all)
      elsif input == "glass"
        CocktailAPI.getGlasses if Glass.all == []
        print_selection(Glass.all)
        select_from_group("glass", Glass.all)
      elsif input == "ingredient"
        CocktailAPI.getIngredients if Ingredient.all == []
        print_selection(Ingredient.all)
        select_from_group("ingredient", Ingredient.all)
      elsif input == "alcoholic"
        CocktailAPI.getAlcoholic if Alcoholic.all == []
        print_selection(Alcoholic.all)
        select_from_group("alcoholic", Alcoholic.all)
      end
    end
  end

  def select_from_group(main_group_type, group)
    puts "Type the number of the #{main_group_type} from which you would like to select"
    input = gets.strip.downcase
    drinks = []
    drinks = Cocktail.find_by_group(main_group_type, group[input.to_i-1].name.gsub(" ","_"))
    if drinks.length == 0
      CocktailAPI.getDrinksByGroup(main_group_type, group[input.to_i-1].name.gsub(" ","_"))
      drinks = Cocktail.find_by_group(main_group_type, group[input.to_i-1].name.gsub(" ","_"))
    end
    print_drinks_in_group(drinks)
    while input != "menu"
      puts "Type the number of the drink you would like to see, 'list' to see the list again or 'menu' to return to the main menu."
      puts ""
      input = gets.strip
      if input == 'list'
        print_drinks_in_group(drinks)
      elsif input.to_i > 0 && input.to_i <= drinks.length
        if drinks[input.to_i-1].ingredients == []
          drink = CocktailAPI.getDrinkDetails(drinks[input.to_i-1].drink_id)
        else
          drink = drinks[input.to_i-1]
        end
        print_drink(drink)
        puts ""
      elsif input != 'menu'
        puts "Oops, I didn't understand that"        # puts "Type the number of the drink you would like to see, 'list' to see the list again or 'menu' to return to the main menu."
      end
    end
  end

  def print_selection(selected)
    puts ""
    selected.each.with_index(1) do |value, index|
      puts "#{index}. #{value.name}"
    end
    puts ""
  end

  def print_drinks_in_group(group)
    puts ""
    group.each.with_index(1) do |value, index|
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
