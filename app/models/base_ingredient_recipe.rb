class BaseIngredientRecipe < ApplicationRecord
  belongs_to :base_ingredient
  belongs_to :recipe

end
