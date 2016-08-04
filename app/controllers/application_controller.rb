class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include ApplicationHelper
  include DateHelper
  include UserHelper
  include DataHelper

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
