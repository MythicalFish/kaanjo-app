class ProductsController < ApplicationController

  def index
    @title = "Products"
    @products = current_webmaster.products.with_totals(sorted)
  end

  def show
    @product = Product.find_by_sid(params[:id])
    @title = @product.name
    @devices = @product.device_stats(sorted)
  end

end
