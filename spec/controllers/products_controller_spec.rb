require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    context 'more than 10 availabe products' do
      before(:example) do
        create_list(:product, 15)
      end

      it 'assigns a maximum of 10 products' do
        get :index
        expect(assigns(:products).count).to eq 10
      end

      it 'is paginated' do
        page = 2
        get :index, params: { page: page }
        expect(assigns(:products)).to eq Product.all.page(page)
      end
    end

    context 'less than 10 availabe products' do
      before(:example) do
        create_list(:product, 5)
      end

      it 'assigns all products' do
        get :index
        expect(assigns(:products).count).to eq Product.count
      end
    end
  end
end
