class ReactionsApi < WebsocketRails::BaseController

  def initialize_session
    controller_store[:webmaster_id] = nil
  end

  # Webmasters

  def find_webmaster

    @webmaster = Webmaster.find_by_website(message[:website])
    
    if @webmaster
      controller_store[:webmaster_id] = @webmaster.id
      trigger_success
    else
      trigger_failure
    end

  end

  # Customers

  def create_customer
    
    @customer = Customer.create
    
    if @customer
      trigger_success({ :sid => @customer.sid })
    else
      trigger_failure({ :errors => @customer.errors })
    end

  end

  # Products

  def find_product

    @product = webmaster.products.find_by_name(message[:product_name])

    if @product
      trigger_success({
        data: @product.reaction_totals
      })
    else
      trigger_failure({ errors: @product.errors })
    end
    
  end

  private

  def webmaster
    if id = controller_store[:webmaster_id]
      Webmaster.find(id)
    end
  end

end
