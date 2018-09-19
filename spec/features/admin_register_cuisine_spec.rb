require 'rails_helper'

feature 'Administrator register cuisine' do

  scenario 'sucessfully' do 
    
    visit root_path

    click_on 'Cadastrar uma Cozinha'

    fill_in 'Nome', with: 'Japonesa'

    click_on 'Cadastrar'

    expect(page).to have_css('h1', text: 'Japonesa')
    expect(page).to have_css('div.alert.alert-success', text: 'Cozinha cadastrada com sucesso' )

  end

  scenario 'and must fill in all field' do

    visit root_path

    click_on 'Cadastrar uma Cozinha'

    fill_in 'Nome', with: ''

    click_on 'Cadastrar'

    expect(page).to have_content("Você deve preencher todos os campos")
  end

  scenario 'and duplicated cuisine' do

    Cuisine.create(name: 'Japonesa')

    visit root_path

    click_on 'Cadastrar uma Cozinha'

    fill_in 'Nome', with: 'Japonesa'

    click_on 'Cadastrar'

    expect(page).to have_css('div.alert.alert-warning', text: 'Esse tipo de cozinha já existe')

  end

end