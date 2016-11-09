class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user_custom
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  layout :layout_by_resource

  include ApplicationHelper
  include DateHelper
  include UserHelper
  include DataHelper
  include ChartHelper

  protected

  def configure_permitted_parameters
    custom_attributes = [:email, :password, :first_name, :last_name, :website_url, :website_name, 
      :title, :address1, :address2 ,:city, :postcode, :country, :phone]
    devise_parameter_sanitizer.permit(:account_update, keys: custom_attributes)
    devise_parameter_sanitizer.permit(:sign_up, keys: custom_attributes)
  end

  def authenticate_user_custom
    authenticate_user! unless request.path == "/"
  end

  def layout_by_resource
    if devise_controller?
      'island'
    else
      'application'
    end
  end

end
