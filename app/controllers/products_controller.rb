class ProductsController < ApplicationController
  def index
    @products = Product.where(params.slice(:category))
  end

  def show

  end

  def position

  end
end

