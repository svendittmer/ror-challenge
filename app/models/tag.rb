# implements tagging functionality for products
class Tag < ApplicationRecord
  validates :title, presence: true
end
