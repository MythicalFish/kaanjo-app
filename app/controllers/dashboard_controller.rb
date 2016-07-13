class DashboardController < ApplicationController

  def show
    if current_user.admin?
      @webmasters = Webmaster.all
      render 'webmasters/index'
    else
      redirect_to products_path
    end
  end

end
