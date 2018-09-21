require 'rails_helper'

feature 'User update recipe' do
  scenario 'view edit button' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')

    user = User.create(email: 'teste@teste.com.br', password: '12345678')

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

    expect(current_path).to eq root_path

    click_on 'Bolo de cenoura'

    expect(page).to have_css('a.btn.btn-primary', text: 'Editar')
  end

  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Arabe')

    user = User.create(email: 'teste@teste.com.br', password: '12345678')

    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    # simula a ação do usuário
    visit root_path

    click_on 'Entrar'

    within 'form' do
      fill_in 'Email', with: 'teste@teste.com.br'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end

    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
    expect(page).to have_css('p', text: 'teste@teste.com.br')
  end

  scenario 'and must fill in all fields' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'teste@teste.com.br', password: '12345678')
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    # simula a ação do usuário
    visit root_path

    click_on 'Entrar'

    within 'form' do
      fill_in 'Email', with: 'teste@teste.com.br'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end

    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and its not his recipe' do
    
    user_owner = User.create(email: 'user@owner.com.br', password: '12345678')
    not_user_owner = User.create(email: 'notuser@owner.com.br', password: '12345678')

    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user_owner)

    visit root_path

    click_on 'Entrar'

    within 'form' do
      fill_in 'Email', with: 'notuser@owner.com.br'
      fill_in 'Senha', with: '12345678'

      click_on 'Entrar'
    end

    click_on 'Bolo de cenoura'

    expect(page).not_to have_link('Editar')
  end
end
