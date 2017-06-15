# join model for tagging products with tags
class Tagging < ApplicationRecord
  belongs_to :product
  belongs_to :tag

  validates :product, :tag, presence: true
end
