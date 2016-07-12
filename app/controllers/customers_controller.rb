class CustomersController < ApplicationController

  def index
    @customers = current_user.customers
  end

  def show
    @customer = current_user.customers.find(params[:id])
  end
  
end
