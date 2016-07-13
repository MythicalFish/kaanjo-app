class ProductsController < ApplicationController

  def index
    @products = current_user.products
  end

  def show
    @product = Product.find(params[:id])
  end

end
