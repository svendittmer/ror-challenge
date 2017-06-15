require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET /products' do
    context 'more than 10 availabe products' do
      before(:example) do
        create_list(:product, 15, tags: build_list(:tag, 3))
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
        create_list(:product, 5, tags: build_list(:tag, 3))
      end

      it 'assigns all products' do
        get :index
        expect(assigns(:products).count).to eq Product.count
      end
    end
  end

  describe 'POST /products' do
    context 'with valid parameters' do
      let(:tag_attributes) do
        Array
          .new(3) { attributes_for(:tag) }
          .map.with_index { |attributes, index| [index, attributes] }
          .to_h
      end

      let(:attr) do
        { product: attributes_for(:product).merge(tags_attributes: tag_attributes) }
      end

      it 'creates a new product and redirects there' do
        expect { post :create, params: attr }.to change(Product, :count).by(1)
        expect(response).to redirect_to(assigns(:product))
      end
    end

    context 'invalid parameters' do
      let(:attr) do
        { product: { name: '', price: '12.99' } }
      end

      it 'does not save the product' do
        expect { post :create, params: attr }.to change(Product, :count).by(0)
      end
    end
  end

  describe 'PUT /products/:id' do
    before(:example) do
      @product = create(:product, name: 'old name', price: 1.99, tags: build_list(:tag, 3))
    end

    context 'with valid parameters' do
      let(:attr) do
        { product: { name: 'new name', price: '12.75' } }
      end

      it 'updates the product and redirects there' do
        patch :update, params: { id: 1 }.merge(attr)
        expect(@product.reload.name).to eq attr[:product][:name]
        expect(response).to redirect_to(assigns(:product))
      end
    end

    context 'invalid parameters' do
      let(:attr) do
        { product: { name: '', price: '12.99' } }
      end

      it 'does not change the product' do
        patch :update, params: { id: 1 }.merge(attr)
        expect(@product.reload.name).to_not eq attr[:product][:name]
      end
    end
  end

  describe 'DELETE /products/:id' do
    before(:example) do
      @product = create(:product, tags: build_list(:tag, 3))
    end

    it 'deletes the product and redirects to /products' do
      expect { delete :destroy, params: { id: 1 } }.to change(Product, :count).by(-1)
      expect(response).to redirect_to('/products')
    end
  end
end
