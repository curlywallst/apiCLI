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
    category = Category.all[input.to_i-1].split.joins("-")
    drinks = CocktailAPI.getDrinksByCategory(category)
    Cocktail.all.each.with_index(1) do |value, index|
      puts "#{index}. #{value.name}"
    end
    puts "Type the number of the drink you would like to see or 'list' to see the list again."
    input = gets.strip
    drink = CocktailAPI.getDrinkDetails(input.to_i)
    # [input.to_i-1].tr(" ","_")

    binding.pry
  end



end
