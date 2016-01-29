class CreateCategoryListings < ActiveRecord::Migration
  def change
    create_view :category_listings
  end
end
