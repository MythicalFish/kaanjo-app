class WebmastersController < ApplicationController

  before_action :authorize

  respond_to :html

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

  def new
    @title = "New webmaster"
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
    @webmaster = Webmaster.new(webmaster_params)
    @webmaster.confirmed_at = Time.now
    if @webmaster.save
      flash[:notice] = "Webmaster created"
      redirect_to webmasters_path
    else
      flash[:alert] = "Webmaster creation failed: #{@webmaster.errors.full_messages.to_sentence}"
      respond_with @webmaster, location: new_webmaster_path
    end
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
    params.require(:webmaster).permit(:email, :password, :first_name, :last_name, :website_url, :website_name)
  end

  def authorize
    unless current_user && current_user.admin?
      head(403)
    end
  end

end
