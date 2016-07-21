class AdminsController < ApplicationController

  before_action :authorize

  def index
    @title = "Administrators"
    @admins = Admin.all
  end

  def edit 
    @admin = admin.find(params[:id])
    @title = @admin.name
  end

  def new
    @title = "New admin"
  end

  def update

    @admin = admin.find(params[:id])

    if params[:admin][:password].blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if !passwords_match
      flash[:alert] = "Error: passwords did not match"
    elsif @admin.update_attributes(admin_params)
      flash[:notice] = 'Administrator updated'
    else
      flash[:alert] = "Error: #{@admin.errors.full_messages.to_sentence}"
    end
    redirect_to edit_admin_path(@admin)

  end

  def product
    @admin = admin.find(params[:id])
    @product = @admin.products.find(params[:product_id])
  end

  def create
    w = admin.new(admin_params)
    if w.save
      redirect_to admin_path(w)
    else
      
    end
  end

  def products

  end

  private

  def passwords_match
    if params[:admin][:password]
      if params[:admin][:password] != params[:admin][:password_confirmation]
        return false
      end
    end
    true
  end

  def admin_params
    params.require(:admin).permit(:email, :password, :first_name, :last_name, :website)
  end

  def authorize
    unless current_user && current_user.admin?
      head(403)
    end
  end

end
