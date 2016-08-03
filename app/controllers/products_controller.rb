class ProductsController < ApplicationController

  include ReactionQueries

  def index
    @title = "Products"
    @products = current_webmaster.products.with_counts(reaction_sorting)
  end

  def show
    @product = Product.find_by_sid(params[:sid])
    @title = @product.name
  end

end
