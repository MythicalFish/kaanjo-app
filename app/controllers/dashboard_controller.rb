class DashboardController < ApplicationController

  def show
    if current_user.admin?
      @webmasters = Webmaster.all
      render 'admin/dashboard'
    else
      @products = current_user.products
      render 'webmasters/show'
    end
  end

end
