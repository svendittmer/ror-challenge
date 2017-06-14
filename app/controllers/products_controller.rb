# provides CRUD operations for products
class ProductsController < ApplicationController
  def index
    @products = Product.page params[:page]
  end
end
