class Category::Listing < ApplicationRecord
  default_scope -> { order('name asc') }

  def to_param; name&.parameterize; end

  def to_s; name.to_s; end
end
