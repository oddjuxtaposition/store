class Product < ApplicationRecord
  has_many :categorizations,
    dependent: :delete_all

  has_many :categories,
    through: :categorizations
end
