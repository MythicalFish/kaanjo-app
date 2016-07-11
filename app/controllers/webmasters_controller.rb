class WebmastersController < ApplicationController

  before_action :authorize

  def show

  end

  def create
    if Webmaster.create(webmaster_params)
      render 'show'
    else
      
    end
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
