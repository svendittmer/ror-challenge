require 'rails_helper'

describe 'products/show' do
  it 'displays all the widgets' do
    assign(:product, Product.create(
                       name: 'Crispy product',
                       price: 12.99,
                       tags_attributes: [
                         { title: 'crispy' },
                         { title: 'sweet' },
                         { title: 'neat' }
                       ]
    ))

    Product.create([{
                     name: 'Tasty product',
                     price: 13.99,
                     tags_attributes: [
                       { title: 'crispy' },
                       { title: 'sweet' },
                       { title: 'tasty' }
                     ]
                   }, {
                     name: 'Cool product',
                     price: 13.99,
                     tags_attributes: [
                       { title: 'crispy' },
                       { title: 'cool' },
                       { title: 'funny' }
                     ]
                   }])

    render

    expect(rendered).to have_css('table tbody tr:nth-of-type(1) td:nth-of-type(2)', text: 'Used in 3 products')
    expect(rendered).to have_css('table tbody tr:nth-of-type(3) td:nth-of-type(2)', text: 'Used in 1 products')
  end
end
