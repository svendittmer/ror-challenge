require 'rails_helper'

describe 'products/show' do
  before(:each) do
    assign(:product, Product.create(
                       name: 'Crispy product',
                       price: 12.99,
                       tags_attributes: {
                         '0' => { title: 'crispy' },
                         '1' => { title: 'sweet' },
                         '2' => { title: 'neat' }
                       }
    ))

    Product.create([{
                     name: 'Tasty product',
                     price: 13.99,
                     tags_attributes: {
                       '0' => { title: 'crispy' },
                       '1' => { title: 'sweet' },
                       '2' => { title: 'tasty' }
                     }
                   }, {
                     name: 'Cool product',
                     price: 13.99,
                     tags_attributes: {
                       '0' => { title: 'crispy' },
                       '1' => { title: 'cool' },
                       '2' => { title: 'funny' }
                     }
                   }])
    render
  end
  it "displays the usage-count of the product's tags" do
    expect(rendered).to have_css('table tbody tr:nth-of-type(1) td:nth-of-type(2)', text: 'Used in 3 products')
    expect(rendered).to have_css('table tbody tr:nth-of-type(3) td:nth-of-type(2)', text: 'Used in 1 products')
  end

  it 'shows the most similar products, and their similarity' do
    expect(rendered).to have_css('table tbody tr:nth-of-type(1) td:nth-of-type(3)', text: '66.67%')
    expect(rendered).to have_css('table tbody tr:nth-of-type(2) td:nth-of-type(3)', text: '33.33%')
  end
end
