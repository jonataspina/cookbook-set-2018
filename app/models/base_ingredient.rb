class BaseIngredient < ApplicationRecord
  has_many :base_ingredient_recipes
  has_many :recipes, through: :base_ingredient_recipes
end
