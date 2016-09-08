class ProductsController < ApplicationController

  include ReactionSorting

  def index
    @title = "Products"
    @products = current_webmaster.products.with_counts(reaction_sorting)
  end

  def show
    @product = Product.find_by_sid(params[:sid])
    @title = @product.name
    @devices = @product.device_stats(from:from_date,to:to_date)
  end

end
