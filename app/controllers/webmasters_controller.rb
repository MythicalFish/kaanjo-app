class WebmastersController < ApplicationController

  before_action :authorize

  def index
    @title = "Webmasters"
  end

  def show
    @webmaster = Webmaster.find(params[:id])
    @title = "Webmaster: #{@webmaster.name}"
    @products = @webmaster.products.includes([:impressions,:reactions])
  end

  def edit 
    @webmaster = Webmaster.find(params[:id])
  end

  def product
    @webmaster = Webmaster.find(params[:id])
    @product = @webmaster.products.find(params[:product_id])
  end

  def create
    w = Webmaster.new(webmaster_params)
    if w.save
      redirect_to webmaster_path(w)
    else
      
    end
  end

  def products

  end

  private

  def webmaster_params
    params.permit(:email,:password)
  end

  def authorize
    unless current_user && current_user.admin?
      head(403)
    end
  end

end
