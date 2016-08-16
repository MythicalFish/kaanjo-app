class DashboardController < ApplicationController

  def show
    @title = 'Dashboard'
    f = from_date
    t = to_date
    if admin?
      dashboard_for_admin and return
    elsif webmaster?
      w = current_webmaster
      @impression_total = w.impressions.total f,t
      @reaction_total =   w.reactions.total   f,t
      @reaction_counts =  w.reactions.counts  f,t
      @total_ctr = calculate_ctr(@reaction_total, @impression_total).to_s << '%'
      @products =  w.products.top_by_type     f,t
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
