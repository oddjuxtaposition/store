class Product::Listing < ApplicationRecord
  def self.for(category)
    where(category: category&.titleize)
  end

  def readonly?
    true
  end

  def to_param
    name&.parameterize
  end

  def to_partial_path
    'store/products/product'
  end
end

