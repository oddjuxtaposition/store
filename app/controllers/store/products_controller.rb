module Store
  class ProductsController < ApplicationController
    before_action :find_product, except: %w[index position]

    def index
      @products = Product::Listing.for(params[:category])
      render :index
    end

    def position

    end
  end
end

