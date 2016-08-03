class DashboardController < ApplicationController

  def show
    @title = 'Dashboard'
    if current_user.admin?
      render 'dashboard/for_admin'
    elsif current_user
      render 'dashboard/for_webmaster'
    end
  end

end
