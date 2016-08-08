class ReactionsApi < WebsocketRails::BaseController

  before_action :throttle_actions

  def initialize_session
    sesh :webmaster_id, nil
    sesh :product_id, nil
    sesh :customer_id, nil
    sesh :test_mode, true
  end

  # Webmasters

  def find_webmaster

    @webmaster = Webmaster.find_by_sid(message[:key])

    if @webmaster
      sesh :webmaster_id, @webmaster.id
      trigger_success(info("Found webmaster: #{@webmaster.website_name}"))
    else
      trigger_failure(info("Webmaster not found: #{@webmaster.website_name}"))
    end

  end

  # Customers

  def find_customer

    @customer = Customer.find_by_sid(message[:id])

    if !@customer
      @customer = Customer.create(
        webmaster: webmaster
      )
      msg = "Created customer: #{@customer.sid}"
    else
      msg = "Found customer: #{@customer.sid}"
    end

    if @customer
      sesh :customer_id, @customer.id
      trigger_success(info(
        sid: @customer.sid,
        msg: msg
      ))
    else
      trigger_failure(info(@customer.errors))
    end

  end

  def create_impression

    if customer.reacted_to? product
      trigger_success(info({
        :msg => "Customer already reacted to this product."
      })) and return
    end

    impression = product.impressions.create(
      customer_id: customer.id,
      device_type: message[:device]
    )
    
    if impression
      trigger_success(info({
        :msg => "Created impression: #{impression.id}"
      }))
    else
      trigger_failure(info(impression.errors))
    end
  end

  # Products

  def find_product
    
    @product = webmaster.products.find_by_name(message[:product])

    if !@product && webmaster.creation_enabled?
      @product = webmaster.products.create({
        name: message[:product],
        url: message[:url]
      })
      msg = "Created product: #{@product.name}"
    else
      msg = "Found product: #{@product.name}"
    end

    if @product
      
      sesh :product_id, @product.id

      #####if @product.customer

      trigger_success(info(
        data: {
          reactions: @product.reaction_totals
        },
        msg: msg
      ))
    else
      trigger_failure(info(@product.errors))
    end
    
  end

  private

  def info msg
    if sesh[:test_mode]
      if msg.is_a?(String) or msg.is_a?(Array)
        {msg:msg}
      else
        msg
      end
    end
  end

  def throttle_actions

    return unless customer

    time = Time.now 
    index_limit = 5

    if customer.throttle_timer_1.nil? || time > customer.throttle_timer_1
      throttle_reset
    elsif time < customer.throttle_timer_1 && index_limit > customer.throttle_index_1
      throttle_increment
    else
      trigger_failure(info({ errors: 'too many requests' }))
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
