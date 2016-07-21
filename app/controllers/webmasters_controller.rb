class WebmastersController < ApplicationController

  before_action :authorize

  def index
    @title = "Webmasters"
    @webmasters = Webmaster.with_counts(from_date,to_date)
  end

  def show
    @webmaster = Webmaster.find(params[:id])
    @title = "Webmaster: #{@webmaster.name}"
    @products = @webmaster.products.with_counts
  end

  def edit 
    @webmaster = Webmaster.find(params[:id])
    @title = @webmaster.name
  end

  def update

    @webmaster = Webmaster.find(params[:id])

    if params[:webmaster][:password].blank?
      params[:webmaster].delete(:password)
      params[:webmaster].delete(:password_confirmation)
    end

    if !passwords_match
      flash[:alert] = "Error: passwords did not match"
    elsif @webmaster.update_attributes(webmaster_params)
      flash[:notice] = 'Webmaster updated'
    else
      flash[:alert] = "Error: #{@webmaster.errors.full_messages.to_sentence}"
    end
    redirect_to edit_webmaster_path(@webmaster)

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

  def passwords_match
    if params[:webmaster][:password]
      if params[:webmaster][:password] != params[:webmaster][:password_confirmation]
        return false
      end
    end
    true
  end

  def webmaster_params
    params.require(:webmaster).permit(:email, :password, :first_name, :last_name, :website)
  end

  def authorize
    unless current_user && current_user.admin?
      head(403)
    end
  end

end
