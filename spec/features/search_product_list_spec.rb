require 'rails_helper'

RSpec.feature 'Searchable product list', type: :feature do
  before :each do
    create(:product,
           name: 'Cheap product',
           price: '0.99',
           tags_attributes: {
             '0' => { title: 'crispy' },
             '1' => { title: 'sweet' },
             '2' => { title: 'neat' }
           })
    create(:product,
           name: 'Crispy product',
           price: '9.99',
           tags_attributes: {
             '0' => { title: 'crispy' },
             '1' => { title: 'salty' },
             '2' => { title: 'neat' }
           })
    create(:product,
           name: 'Tasty product',
           price: '19.99',
           tags_attributes: {
             '0' => { title: 'salty' },
             '1' => { title: 'sweet' },
             '2' => { title: 'crispy' }
           })
    create(:product,
           name: 'Expensive product',
           price: '999.99',
           tags_attributes: {
             '0' => { title: 'yummy' },
             '1' => { title: 'happy' },
             '2' => { title: 'cool' }
           })
  end

  scenario 'User searches products by price range' do
    visit '/products'

    fill_in 'Minimum price', with: '5.59'
    fill_in 'Maximum price', with: '59.59'

    expect(page).to have_css('tbody tr', count: 4)
    click_button('Search')
    expect(page).to have_css('tbody tr', count: 2)
  end

  scenario 'User searches products by tags' do
    visit '/products'

    fill_in 'search_by_tags', with: 'crispy'
    click_button('Search')
    expect(page).to have_css('tbody tr', count: 3)

    click_link 'Name'
    expect(page).to have_css('tbody tr', count: 3)

    fill_in 'search_by_tags', with: 'crispy, sweet'
    click_button('Search')
    expect(page).to have_css('tbody tr', count: 2)

    fill_in 'Minimum price', with: '5.59'
    click_button('Search')
    expect(page).to have_css('tbody tr', count: 1)
  end
end
