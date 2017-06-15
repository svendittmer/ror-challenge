# dynamic deletion of a product's taggings
class TaggingsController < ApplicationController
  # DELETE /taggings/:id
  def destroy
    tagging = Tagging.find(params[:id])
    product = tagging.product
    product.remove_tagging(tagging)
    redirect_to product
  end
end
