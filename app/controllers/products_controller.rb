# provides CRUD operations for products
class ProductsController < ApplicationController
  # GET /products
  def index
    @products = Product.page params[:page]
  end

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
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  # DELETE /products/:id
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to action: 'index'
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
