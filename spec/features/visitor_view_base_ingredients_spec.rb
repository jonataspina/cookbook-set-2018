require 'rails_helper'

feature 'visitor view base ingredients' do
  scenario 'successfully' do

    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'teste@user.com.br', password: '12345678')

    base_ingredient_first = BaseIngredient.create(name: 'Farinha')
    base_ingredient_second = BaseIngredient.create(name: 'Cenoura')
    
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Médio',
                            cook_time: 60,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                            user: user)
    
    BaseIngredientRecipe.create(base_ingredient: base_ingredient_first, recipe: recipe)
    BaseIngredientRecipe.create(base_ingredient: base_ingredient_second, recipe: recipe)

    visit root_path

    click_on 'Bolo de cenoura'

    expect(page).to have_css('h3', text: 'Ingredientes Base')
    expect(page).to have_css('li', text: 'Farinha')
    expect(page).to have_css('li', text: 'Cenoura')
  end
end