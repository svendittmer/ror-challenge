# the challenge's main model
class Product < ApplicationRecord
  monetize :price_cents

  MINIMUM_TAG_COUNT = 3

  before_validation :prepare_tags, if: proc { |product| product.tags_attributes.present? }

  has_many :taggings, dependent: :destroy, autosave: true
  has_many :tags, through: :taggings, autosave: true

  validates :name, :price, presence: true
  validate :minimum_tag_count

  attr_accessor :tags_attributes

  def remove_tagging(tagging)
    taggings.destroy(tagging) if tags.size > MINIMUM_TAG_COUNT
  end

  private

  def prepare_tags
    tags_attributes.each do |tag_attributes|
      tags << Tag.find_or_initialize_by(tag_attributes)
    end
  end

  def minimum_tag_count
    if tags.size < MINIMUM_TAG_COUNT
      errors[:tag_count] << "must be greater than or equal to #{MINIMUM_TAG_COUNT}"
    end
  end
end
