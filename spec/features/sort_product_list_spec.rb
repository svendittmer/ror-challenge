require 'rails_helper'

RSpec.feature 'Sortable product list', type: :feature do
  let(:last_product_name_selector) do
    'tbody tr:last-of-type td:first-of-type'
  end

  let(:first_product_name_selector) do
    'tbody tr:first-of-type td:first-of-type'
  end

  let(:last_product_price_selector) do
    'tbody tr:last-of-type td:nth-of-type(2)'
  end

  let(:first_product_price_selector) do
    'tbody tr:first-of-type td:nth-of-type(2)'
  end

  before :each do
    create(:product, name: 'Crispy product', price: '9.99', tags: build_list(:tag, 3))
    create(:product, name: 'Tasty product', price: '19.99', tags: build_list(:tag, 3))
    create(:product, name: 'Expensive product', price: '999.99', tags: build_list(:tag, 3))
  end

  scenario 'User sorts products by name' do
    visit '/products'

    click_link('Name')

    expect(page).to have_css(first_product_name_selector, text: 'Crispy product')
    expect(page).to have_css(last_product_name_selector, text: 'Tasty product')

    click_link('Name')

    expect(page).to have_css(first_product_name_selector, text: 'Tasty product')
  end

  scenario 'User sorts products by price' do
    visit '/products'

    click_link('Price')

    expect(page).to have_css(first_product_price_selector, text: '€9.99')

    click_link('Price')

    expect(page).to have_css(first_product_price_selector, text: '€999.99')
  end

  scenario 'User uses sort and search together' do
    visit '/products'

    click_link('Price')

    fill_in 'minimum price', with: '5.59'
    fill_in 'maximum price', with: '59.59'

    click_button('Search')

    expect(page).to have_selector('tbody tr', count: 2)
    expect(page).to have_css(last_product_price_selector, text: '€19.99')

    click_link('Price')

    expect(page).to have_selector('tbody tr', count: 2)
    expect(page).to have_css(last_product_price_selector, text: '€9.99')

    click_link('Name')

    expect(page).to have_selector('tbody tr', count: 2)
    expect(page).to have_css(first_product_name_selector, text: 'Crispy product')
  end
end
