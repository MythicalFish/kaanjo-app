class DashboardController < ApplicationController

  def show
    if current_user.admin?
      @webmasters = Webmaster.all
      render 'admin'
    else
      @products = current_user.products
      render 'webmaster'
    end
  end

end
