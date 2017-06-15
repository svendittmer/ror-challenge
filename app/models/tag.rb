# implements tagging functionality for products
class Tag < ApplicationRecord
  validates :title, presence: true

  has_many :taggings

  # returns how many products were tagged with this tag
  def usage_count
    taggings.count
  end
end
