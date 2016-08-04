class DashboardController < ApplicationController

  def show
    @title = 'Dashboard'
    if admin?
      render 'dashboard/for_admin'
    elsif webmaster?
      w = current_webmaster
      f = from_date
      t = to_date
      @impression_total = w.impressions.total f,t
      @reaction_total =   w.reactions.total   f,t
      @reaction_counts =  w.reactions.counts  f,t
      @products =  w.products.top_by_type     f,t
      render 'dashboard/for_webmaster'
    else
      raise "Neither admin nor webmaster"
    end
  end

end
