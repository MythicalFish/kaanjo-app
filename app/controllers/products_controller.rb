class ProductsController < ApplicationController

  def index
    @title = "Products"
    @products = current_webmaster.products.with_counts(args)
  end

  def show
    @product = Product.find(params[:id])
    @title = @product.name
  end

  private

  def args
    args = {
      from: from_date,
      to: to_date
    }

    args[:order] = params[:a] if params[:a]
    args[:direction] = params[:d] if params[:d]
    args[:direction] = 'ASC' if args[:direction] == 'up'
    args[:direction] = 'DESC' if args[:direction] == 'down'
    args
  end

end
