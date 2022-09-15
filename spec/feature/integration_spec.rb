# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path

    fill_in 'Title', with: 'harry potter'
    fill_in 'Author', with: 'J.K. Rowling'
    fill_in 'Price', with: 4.19
    fill_in 'Published date', with: '1997-01-07'
  
    click_on 'Create Book'
    visit books_path
    expect(page).to have_content('harry potter')
    expect(page).to have_content('J.K. Rowling')
    expect(page).to have_content(4.19)
    expect(page).to have_content('1997-01-07')
  end
  
  scenario 'invalid title, valid otherwise' do
    visit new_book_path

    fill_in 'Title', with: nil
    fill_in 'Author', with: 'J.K. Rowling'
    fill_in 'Price', with: 4.19
    fill_in 'Published date', with: '1997-01-07'

    click_on 'Create Book'
    expect(page).to have_content('prohibited this book from being saved')
  end

  scenario 'invalid author, valid otherwise' do
    visit new_book_path
    
    fill_in 'Title', with: 'harry potter'
    fill_in 'Author', with: nil
    fill_in 'Price', with: 4.19
    fill_in 'Published date', with: '1997-01-07'

    click_on 'Create Book'
    expect(page).to have_content('prohibited this book from being saved')
  end

  scenario 'invalid price, valid otherwise' do
    visit new_book_path
    
    fill_in 'Title', with: 'harry potter'
    fill_in 'Author', with: 'J.K. Rowling'
    fill_in 'Price', with: nil
    fill_in 'Published date', with: Date.new(1997,1,7)

    click_on 'Create Book'
    expect(page).to have_content('prohibited this book from being saved')
  end

  scenario 'invalid published date, valid otherwise' do
    visit new_book_path
    
    fill_in 'Title', with: 'harry potter'
    fill_in 'Author', with: 'J.K. Rowling'
    fill_in 'Price', with: 4.19
    fill_in 'Published date', with: nil

    click_on 'Create Book'
    expect(page).to have_content('prohibited this book from being saved')
  end
end