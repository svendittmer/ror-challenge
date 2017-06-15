# implements tagging functionality for products
class Tag < ApplicationRecord
  before_save { self.title = title.strip }

  validates :title,
            presence: true,
            format: { with: /\A[^,]*\z/, message: 'allows no comma' }

  has_many :taggings

  # returns how many products were tagged with this tag
  def usage_count
    taggings.count
  end
end
