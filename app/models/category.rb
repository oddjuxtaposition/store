class Category < ApplicationRecord
  has_many :categorizations,
    class_name: 'Product::Categorization',
     dependent: :delete_all

  has_many :products,
    through: :categorizations

  def to_param; name&.parameterize; end

  def to_s; name.to_s; end
end
