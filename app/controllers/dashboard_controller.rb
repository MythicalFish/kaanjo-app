class DashboardController < ApplicationController

  include ReactionSorting

  def show
    @title = 'Dashboard'
    if admin?
      dashboard_for_admin
    elsif webmaster?
      dashboard_for_webmaster
    else
      render 'devise/sessions/new', locals: { resource: User.new }
    end
  end

  private

  def dashboard_for_admin
    @webmasters = Webmaster.with_totals(reaction_sorting)
    render 'webmasters/index'
  end

  def dashboard_for_webmaster
    @campaigns = current_webmaster.campaigns.with_totals(reaction_sorting)
    render 'campaigns/index'
  end

end
