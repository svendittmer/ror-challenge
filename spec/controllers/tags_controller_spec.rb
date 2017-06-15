require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe 'POST /products/:id/tags' do
    before(:each) do
      @product = create(:product, tags: build_list(:tag, 3))
    end

    context 'with valid parameters' do
      let(:attr) do
        { tag: { title: 'New Tag' } }
      end

      it 'creates a new tagging and redirects back to the product' do
        expect { post 'create', params: attr.merge(product_id: @product.id) }.to change(Tagging, :count).by(1)
        expect(response).to redirect_to(@product)
      end
    end

    context 'invalid parameters' do
      let(:attr) do
        { tag: { title: '' } }
      end

      it 'does not save the tagging' do
        expect { post :create, params: attr.merge(product_id: @product.id) }.to change(Tagging, :count).by(0)
      end
    end
  end
end
