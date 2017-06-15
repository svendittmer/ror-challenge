# the challenge's main model
class Product < ApplicationRecord
  SimilarProduct = Struct.new(:product, :similarity)

  monetize :price_cents

  MINIMUM_TAG_COUNT = 3

  before_validation :prepare_tags, if: proc { |product| product.tags_attributes.present? }

  has_many :taggings, dependent: :destroy, autosave: true
  has_many :tags, through: :taggings, autosave: true

  validates :name, :price, presence: true
  validate :minimum_tag_count

  attr_accessor :tags_attributes

  # returns all products that include all given tags
  def self.search_by_tags(tag_titles)
    tag_titles.each_with_index.reduce(Product.all) do |relation, (term, index)|
      taggings_alias = "taggings_#{index}"
      tag_alias = "tag_#{index}"
      relation
        .joins("INNER JOIN taggings AS #{taggings_alias} ON #{taggings_alias}.product_id = products.id")
        .joins("INNER JOIN tags AS #{tag_alias} ON #{taggings_alias}.tag_id = #{tag_alias}.id")
        .where("#{tag_alias}.title = ?", term)
    end
  end

  # removes a tagging if possible
  def remove_tagging(tagging)
    taggings.destroy(tagging) if tags.size > MINIMUM_TAG_COUNT
  end

  # returns a struct that contains the product and the similarity
  # Similarity is based on the number of matching tags that the product
  # has in common with the product
  def most_similar_products
    matches = Tagging
              .exclude_product_id(id)
              .best_matching_product_ids_with_match_count(tag_ids)
    Product
      .where(id: matches.map(&:first)).includes(:tags)
      .map do |product|
        SimilarProduct.new product,
                           percental_similiarity_by_matching_tags(matches[product.id])
      end
      .sort_by(&:similarity).reverse
  end

  private

  def tag_count
    @tag_count ||= tags.count
  end

  def percental_similiarity_by_matching_tags(matching_tag_count)
    (matching_tag_count.to_f / tag_count * 100)
  end

  def prepare_tags
    tags_attributes.map(&:second).each do |tag_attributes|
      tags << Tag.find_or_initialize_by(tag_attributes)
    end
  end

  def minimum_tag_count
    if tags.size < MINIMUM_TAG_COUNT
      errors[:tag_count] << "must be greater than or equal to #{MINIMUM_TAG_COUNT}"
    end
  end
end
