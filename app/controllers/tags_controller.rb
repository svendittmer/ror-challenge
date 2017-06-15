# dynamic creation of a product's taggings.
class TagsController < ApplicationController
  # POST /products/:product_id/tags
  # creates the tag on the fly, if it didn't exist
  def create
    @product = Product.find(params[:product_id])
    @tag = Tag.find_or_initialize_by(tag_params)
    if @tag.valid?
      Tagging.find_or_create_by(tag: @tag, product: @product) if @tag.valid?
      redirect_to @product
    else
      render 'products/show'
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:title)
  end
end
