require './lib/recipe'
require 'pry'

class Pantry
  attr_reader :stock,
              :shopping_list,
              :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = {}
  end

  def stock_check(ingredient)
    if @stock.include?(ingredient)
      @stock[ingredient]
    else
      0
    end
  end

  def restock(ingredient, amount)
    if @stock.include?(ingredient) != true
      @stock[ingredient] = amount
    else
      @stock[ingredient] += amount
    end
  end

  def add_to_the_shopping_list(recipe)
    recipe.ingredients.map do |key, value|
      if shopping_list.include?(key)
        shopping_list[key] += value
      else
        shopping_list[key] = value
      end
    end
  end

  def print_shopping_list
    print_out = shopping_list.map do |key, value|
      "* #{key}: #{value}" + "\n"
    end

    print_out.join
  end

  def add_to_cookbook(recipe)
    cookbook[recipe.name] = recipe.ingredients
  end

  def what_can_i_make
  cookbook.values
  binding.pry
  stock
  end
end
