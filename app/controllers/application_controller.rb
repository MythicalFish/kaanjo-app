class ApplicationController < ActionController::Base

  include ApplicationHelper

  def dashboard
    if current_user.admin?
      redirect_to webmasters_path
    else
      redirect_to products_path
    end
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception # TODO

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    custom_attributes = [:first_name, :last_name, :website_url, :website_name]
    devise_parameter_sanitizer.permit(:account_update, keys: custom_attributes)
    devise_parameter_sanitizer.permit(:sign_up, keys: custom_attributes)
  end


  #before_filter :add_allow_credentials_headers #TODO

  # TODO: not sure if needed
  #def add_allow_credentials_headers                                                                                                                                                                                                                                                        
  #  response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'                                                                                                                                                                                                     
  #  response.headers['Access-Control-Allow-Credentials'] = 'true'                                                                                                                                                                                                                          
  #end 
#
#  #def options                                                                                                                                                                                                                                                                              
#  #  head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'                                                                                                                                                                                                         
  #end


end
