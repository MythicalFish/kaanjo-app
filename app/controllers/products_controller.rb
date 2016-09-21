class ProductsController < ApplicationController

  include ReactionSorting

  def index
    @title = "Products"
    @products = current_webmaster.products.with_totals(reaction_sorting)
  end

  def show
    @product = Product.find_by_sid(params[:sid])
    @title = @product.name
    @devices = @product.device_stats(reaction_sorting)
  end

end
