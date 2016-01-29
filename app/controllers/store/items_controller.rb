class Store::ItemsController < ApplicationController
  before_action :find_product, except: :index

  def index
  end

  def create
    current_cart.items.create! product_id: @product.id
    redirect_to store_product_listing_url
  end
end

