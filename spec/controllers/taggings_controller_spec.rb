require 'rails_helper'

RSpec.describe TaggingsController, type: :controller do
  describe 'DELETE /taggings/:id' do
    before(:example) do
      @product = create(:product, tags: build_list(:tag, 4))
    end

    it 'deletes the tagging and redirects to its product' do
      expect { delete :destroy, params: { id: 1 } }.to change(Tagging, :count).by(-1)
      expect(response).to redirect_to(@product)
    end
  end
end
