class CreateBaseIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :base_ingredients do |t|
      t.string :name

      t.timestamps
    end
  end
end
