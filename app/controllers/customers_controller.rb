class CustomersController < ApplicationController

  def index
    @customers = current_user.customers
  end

  def show
    @customer = current_user.customers.find(params[:id])
  end

  def create
    @customer = Customer.create
    respond_to do |format|
      format.json { render json: { sid: @customer.sid } }
    end
  end

  private

 
  
end
