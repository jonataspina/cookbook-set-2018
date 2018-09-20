require 'rails_helper'

feature 'user remove a recipe' do

  scenario 'successfully' do

    user = User.create(email: 'teste@teste.com.br', password: '12345678')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    visit root_path

    click_on 'Entrar'

    within 'form' do
      fill_in 'Email', with: 'teste@teste.com.br'
      fill_in 'Senha', with: '12345678'

      click_on 'Entrar'
    end

    click_on 'Bolo de cenoura'

    click_on 'Remover'

    expect(page).to have_content('Receita removida com sucesso')
    expect(page).not_to have_content('Bolo de cenoura')

  end

end