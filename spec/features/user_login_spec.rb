require 'rails_helper'

feature 'user login' do

  scenario 'successfully' do

    User.create(email: 'teste@teste.com.br', password: '12345678')

    visit root_path

    click_on 'Entrar'
    within('form') do
      fill_in 'Email', with: 'teste@teste.com.br'
      fill_in 'Senha', with: '12345678'
    
      click_on 'Entrar'
    end

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
    expect(page).to have_content('Olá teste@teste.com.br')

  end 

  scenario 'and user logout' do

    User.create(email: 'teste@teste.com.br', password: '12345678')

    visit root_path
    click_on 'Entrar'
      
    within('form') do
      fill_in 'Email', with: 'teste@teste.com.br'
      fill_in 'Senha', with: '12345678'
    
      click_on 'Entrar'
    end

    click_on 'Sair'
    
    expect(current_path).to eq root_path
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
    expect(page).not_to have_content('Olá teste@teste.com.br')

  end

end 