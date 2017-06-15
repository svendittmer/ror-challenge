# provides CRUD operations for products
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products
  def index
    @q = Product.ransack(params[:q])
    @products =
      @q.result
        .search_by_tags(tag_search_params)
        .page(params[:page]).includes(taggings: :tag)
  end

  # GET /products/:id
  def show
    @tag = Tag.new
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.tags << Array.new(3, Tag.new)
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

  def tag_search_params
    params[:search_by_tags]&.split(',')&.map(&:strip) || []
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, tags_attributes: %i[title])
  end
end
