# provides CRUD operations for products
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products
  def index
    @products = Product.page params[:page]
  end

  # GET /products/:id
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/:id/edit
  def edit; end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  # PUT /products/:id
  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    redirect_to action: 'index'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
