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

end