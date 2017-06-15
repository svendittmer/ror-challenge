require 'rails_helper'

RSpec.feature 'Searchable product list', type: :feature do
  before :each do
    create(:product, name: 'Cheap product', price: '0.99', tags: build_list(:tag, 3))
    create(:product, name: 'Crispy product', price: '9.99', tags: build_list(:tag, 3))
    create(:product, name: 'Tasty product', price: '19.99', tags: build_list(:tag, 3))
    create(:product, name: 'Expensive product', price: '999.99', tags: build_list(:tag, 3))
  end

  scenario 'User searches products by price range' do
    visit '/products'

    fill_in 'minimum price', with: '5.59'
    fill_in 'maximum price', with: '59.59'

    expect(page).to have_css('tbody tr', count: 4)
    click_button('Search')
    expect(page).to have_css('tbody tr', count: 2)
  end
end
