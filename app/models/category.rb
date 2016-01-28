class Category < ApplicationRecord
  has_many :categorizations,
    class_name: 'Product::Categorization',
     dependent: :delete_all

  has_many :products,
    through: :categorizations
end
