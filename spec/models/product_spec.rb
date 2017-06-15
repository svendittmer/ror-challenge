require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:context) do
    @product = described_class.new
  end

  it 'validates presence of name' do
    @product.name = nil
    expect(@product.save).to be false
    expect(@product.errors[:name]).to include("can't be blank")
  end

  it 'validates presence of price' do
    @product.price_cents = nil
    expect(@product.save).to be false
    expect(@product.errors[:price]).to include("can't be blank")
  end

  it 'validates presence of at least 3 tags' do
    @product.assign_attributes(attributes_for(:product))
    @product.tags = []
    expect(@product.save).to be false
    expect(@product.errors[:tag_count]).to include('must be greater than or equal to 3')
  end
end
