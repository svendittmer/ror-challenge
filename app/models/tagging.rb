# join model for tagging products with tags
class Tagging < ApplicationRecord
  belongs_to :product
  belongs_to :tag

  validates :product, :tag, presence: true

  scope :similar_tagged, ->(tag_ids) { where(tag_id: tag_ids) }
  scope :exclude_product_id, ->(product_id) { where.not(product_id: product_id) }

  # returns a hash of the 5 best matching products
  # determined by how many of the tag_ids are included by the product's taggings
  # Format: product_id => match_count
  def self.best_matching_product_ids_with_match_count(tag_ids)
    similar_tagged(tag_ids)
      .order('count_product_id DESC').limit(5)
      .group(:product_id).count(:product_id)
  end
end
