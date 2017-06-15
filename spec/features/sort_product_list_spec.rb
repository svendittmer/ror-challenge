require 'rails_helper'

RSpec.feature 'Sortable product list', type: :feature do
  before :each do
    create(:product, name: 'Crispy product', price: '9.99', tags: build_list(:tag, 3))
    create(:product, name: 'Tasty product', price: '19.99', tags: build_list(:tag, 3))
    create(:product, name: 'Expensive product', price: '999.99', tags: build_list(:tag, 3))
  end

  scenario 'User sorts by name' do
    visit '/products'

    click_link('Name')

    expect(page).to have_css('table tbody tr:nth-of-type(1) td:nth-of-type(1)', text: 'Crispy product')
    expect(page).to have_css('table tbody tr:nth-of-type(2) td:nth-of-type(1)', text: 'Expensive product')

    click_link('Name')

    expect(page).to have_css('table tbody tr:nth-of-type(1) td:nth-of-type(1)', text: 'Tasty product')
  end

  scenario 'User sorts by price' do
    visit '/products'

    click_link('Price')

    expect(page).to have_css('table tbody tr:nth-of-type(1) td:nth-of-type(2)', text: '€9.99')

    click_link('Price')

    expect(page).to have_css('table tbody tr:nth-of-type(1) td:nth-of-type(2)', text: '€999.99')
  end
end
