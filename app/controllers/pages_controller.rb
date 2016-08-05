class PagesController < ApplicationController

  before_action :validate_path

  def show
    render "pages#{request.path}"
  end

  private

  def validate_path
    paths = [ '/setup' ]
    unless paths.include? request.path
      head(404)
    end
  end

end
