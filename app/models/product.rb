# the challenge's main model
class Product < ApplicationRecord
  validates :name, :price, presence: true
  monetize :price_cents
end
