class DashboardController < ApplicationController

  def show
    @title = 'Dashboard'
    if admin?
      render 'dashboard/for_admin'
    elsif webmaster?
      @impression_count = current_webmaster.impression_count(from_date,to_date)
      @reaction_total = current_webmaster.reaction_total(from_date,to_date)
      @reaction_counts = current_webmaster.reaction_counts(from_date,to_date)
      render 'dashboard/for_webmaster'
    else
      raise "Neither admin nor webmaster"
    end
  end

end
