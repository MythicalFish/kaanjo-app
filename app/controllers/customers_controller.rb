class CustomersController < WebsocketRails::BaseController

  def initialize_session
    controller_store[:message_count] = 0
  end

  def find
    @customer = Customer.find_by_sid(params[:sid])

  end

  def create
puts 'creating'
puts params
    @customer = Customer.create
    
    if @customer
puts 'created'
      trigger_success({ :sid => @customer.sid })
    else
puts 'failed'
puts @customer.errors
      trigger_failure({ :sid => nil })
    end

  end
  
end
