class DashboardController < ApplicationController

  def show
    if current_user.admin?
      @webmasters = Webmaster.all
      render 'webmasters/index'
    else
      @products = current_user.products.includes([:impressions,:reactions])
      render 'webmasters/products/index'
    end
  end

end
