class DashboardController < ApplicationController

  def show
    @title = 'Dashboard'
    if admin?
      dashboard_for_admin
    elsif webmaster?
      dashboard_for_webmaster
    else
      render 'devise/sessions/new', layout: 'island', locals: { resource: User.new }
    end
  end

  private

  def dashboard_for_admin
    @impression_total = Impression.where(created_at:from_date..to_date).length
    @reaction_total =   Reaction.where(created_at:from_date..to_date).length
    @ctr = calculate_ctr(@reaction_total, @impression_total)
    @webmasters = Webmaster.with_totals(sorted)
    render 'webmasters/index'
  end

  def dashboard_for_webmaster
    @campaigns = current_webmaster.campaigns.with_totals(sorted)
    render 'campaigns/index'
  end

end
