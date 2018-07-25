require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new
    @recipe = Recipe.new("Cheese Pizza")
    @recipe.add_ingredient("Cheese", 20)
    @recipe.add_ingredient("Flour", 20)

    @recipe_2 = Recipe.new("Spaghetti")
    @recipe_2.add_ingredient("Spaghetti Noodles", 10)
    @recipe_2.add_ingredient("Marinara Sauce", 10)
    @recipe_2.add_ingredient("Cheese", 5)

    @recipe_3 = Recipe.new("Peanuts")
    @recipe_3.add_ingredient("Raw nuts", 10)
    @recipe_3.add_ingredient("Salt", 10)
  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_it_holds_no_stock_to_start
    assert_equal ({}), @pantry.stock
  end

  def test_it_can_check_for_specific_ingredients_in_stock
    assert_equal 0, @pantry.stock_check("Cheese")
  end

  def test_it_can_restock
    @pantry.restock("Cheese", 10)
    assert_equal 10, @pantry.stock_check("Cheese")
  end

  def test_restock_adds_to_total_amount
    @pantry.restock("Cheese", 10)
    assert_equal 10, @pantry.stock_check("Cheese")
    @pantry.restock("Cheese", 20)
    assert_equal 30, @pantry.stock_check("Cheese")
  end

  def test_it_has_an_empty_shopping_list_by_default
    assert_equal ({}), @pantry.shopping_list
  end

  def test_it_can_add_to_the_shopping_list
    @pantry.add_to_the_shopping_list(@recipe)
    assert_equal ({"Cheese" => 20, "Flour" => 20}), @pantry.shopping_list

    @pantry.add_to_the_shopping_list(@recipe_2)

    expected = ({"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10})
    actual = @pantry.shopping_list

    assert_equal expected, actual
  end

  def test_it_can_print_the_shopping_list
    skip
    @pantry.add_to_the_shopping_list(@recipe)
    @pantry.add_to_the_shopping_list(@recipe_2)

    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    actual = @pantry.print_shopping_list

    assert_equal expected, actual
  end

  def test_it_has_a_cookbook_with_no_recipes
    assert_equal ({}), @pantry.cookbook
  end

  def test_it_can_add_recipes_to_cookbook
    @pantry.add_to_cookbook(@recipe)
    @pantry.add_to_cookbook(@recipe_2)
    @pantry.add_to_cookbook(@recipe_3)

    expected = {@recipe.name => @recipe.ingredients , @recipe_2.name => @recipe_2.ingredients, @recipe_3.name => @recipe_3.ingredients}
    actual = @pantry.cookbook

    assert_equal expected, actual
  end

  def test_it_knows_what_i_can_make
    @pantry.add_to_cookbook(@recipe)
    @pantry.add_to_cookbook(@recipe_2)
    @pantry.add_to_cookbook(@recipe_3)

    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Cucumbers", 120)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)

    expected = ["Pickles", "Peanuts"]
    actual = @pantry.what_can_i_make

    assert_equal expected, actual
  end
end
