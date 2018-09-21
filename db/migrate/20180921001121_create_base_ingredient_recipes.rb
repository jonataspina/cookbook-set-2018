class CreateBaseIngredientRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :base_ingredient_recipes do |t|
      t.references :base_ingredient, foreign_key: true
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
