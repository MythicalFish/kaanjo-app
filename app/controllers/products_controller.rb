class ProductsController < ApplicationController

  def index
    @title = "Products"
    @products = current_webmaster.products.includes([:impressions,:reactions])
  end

  def show
    @product = Product.find(params[:id])
    @title = @product.name
  end

end
