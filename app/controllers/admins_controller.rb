class AdminsController < ApplicationController

  before_action :authorize

  respond_to :html

  def index
    @title = "Administrators"
    @admins = Admin.all
  end

  def edit 
    @admin = Admin.find(params[:id])
    @title = @admin.name
  end

  def new
    @title = "New admin"
  end

  def update

    @admin = Admin.find(params[:id])

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

  def create
    @admin = Admin.new(admin_params)
    @admin.confirmed_at = Time.now
    if @admin.save!(validate:false)
      flash[:notice] = "Admin created"
      redirect_to admins_path
    else
      flash[:alert] = "Admin creation failed: #{@admin.errors.full_messages.to_sentence}"
      respond_with @admin, location: new_admin_path
    end
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
    params.require(:admin).permit(:email, :password, :first_name, :last_name, :website_url, :website_name)
  end

  def authorize
    unless current_user && current_user.admin?
      head(403)
    end
  end

end
