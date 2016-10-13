class DashboardController < ApplicationController

  include ReactionSorting

  def show
    @title = 'Dashboard'
    if admin?
      dashboard_for_admin and return
    elsif webmaster?
      @webmaster = current_webmaster
      @webmaster.setup_totals(reaction_sorting)
      @products =  @webmaster.products.top_by_type from_date, to_date
      render 'dashboard/for_webmaster'
    else
      render 'devise/sessions/new', locals: { resource: User.new }
    end
  end

  def dashboard_for_admin
    @impression_total = Impression.where(created_at:from_date..to_date).length
    @reaction_total =   Reaction.where(created_at:from_date..to_date).length
    @webmasters =  Webmaster.all
    @total_ctr = calculate_ctr(@reaction_total, @impression_total).to_s << '%'
    render 'dashboard/for_admin'
  end

end
