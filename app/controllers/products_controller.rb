class ProductsController < ApplicationController

  def index
    @products = current_webmaster.products.includes([:impressions,:reactions])
  end

  def show
    @product = Product.find(params[:id])
  end

end
