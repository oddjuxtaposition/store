class CreateProductListings < ActiveRecord::Migration
  def change
    create_view :product_listings
  end
end
