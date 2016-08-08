class ReactionsApi < WebsocketRails::BaseController

  before_action :throttle_actions

  def initialize_session
    sesh :webmaster_id, nil
    sesh :product_id, nil
    sesh :customer_id, nil
  end

  # Webmasters

  def find_webmaster

    @webmaster = Webmaster.find_by_sid(message[:key])

    if @webmaster
      sesh :webmaster_id, @webmaster.id
      trigger_success
    else
      trigger_failure
    end

  end

  # Customers

  def find_customer

    @customer = Customer.find_by_sid(message[:id])

    if @customer
      sesh :customer_id, @customer.id
      trigger_success
    else
      trigger_failure
    end

  end


  def create_customer
    
    return if sesh[:customer_id]

    @customer = webmaster.customers.create!
    
    if @customer
      sesh :customer_id, @customer.id
      trigger_success({ :sid => @customer.sid })
    else
      trigger_failure({ :errors => @customer.errors })
    end

  end

  def create_impression

    impression = product.impressions.create(
      customer_id: customer.id,
      device_type: message[:device]
    )
    
    if impression
      trigger_success({:id => impression.id})
    else
      trigger_failure({:errors => impression.errors})
    end
  end

  # Products

  def find_product
    
    @product = webmaster.products.find_by_name(message[:product])
    created = false

    if !@product && webmaster.creation_enabled?
      @product = webmaster.products.create({
        name: message[:product],
        url: message[:url]
      })
      created = true
    end

    if @product
      sesh :product_id, @product.id
      trigger_success({
        data: {
          reactions: @product.reaction_totals
        },
        created: created
      })
    else
      trigger_failure({ errors: @product.errors })
    end
    
  end

  private

  def throttle_actions

    return unless customer

    time = Time.now 
    index_limit = 5

    if customer.throttle_timer_1.nil? || time > customer.throttle_timer_1
      throttle_reset
    elsif time < customer.throttle_timer_1 && index_limit > customer.throttle_index_1
      throttle_increment
    else
      trigger_failure({ errors: 'too many requests' })
    end

  end

  def throttle_reset
    customer.update_attributes!(
      throttle_timer_1: Time.now + 5,
      throttle_index_1: 1
    )
  end

  def throttle_increment
    customer.throttle_index_1 += 1
    customer.save
  end

  def sesh k = nil, v = nil
    
    if k && v
      controller_store[k] = v
    else
      controller_store
    end
  end

  def webmaster
    Webmaster.find(sesh[:webmaster_id]) if sesh[:webmaster_id]
  end

  def product
    Product.find(sesh[:product_id]) if sesh[:product_id]
  end

  def customer
    Customer.find(sesh[:customer_id]) if sesh[:customer_id]
  end

end
