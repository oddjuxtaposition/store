class Product::Categorization < ApplicationRecord
  belongs_to :category
  belongs_to :product
end
