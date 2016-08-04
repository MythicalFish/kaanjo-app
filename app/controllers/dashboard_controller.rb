class DashboardController < ApplicationController

  def show
    @title = 'Dashboard'
    if admin?
      render 'dashboard/for_admin'
    elsif webmaster?
      w = current_webmaster
      f = from_date
      t = to_date
      @impression_count = w.impressions.count_between f, t
      @reaction_total =   w.reactions.count_between f, t
      @reaction_counts =  w.reactions.type_counts_between f, t
      @products =         w.products.top_by_reaction_type f, t
      render 'dashboard/for_webmaster'
    else
      raise "Neither admin nor webmaster"
    end
  end

end
