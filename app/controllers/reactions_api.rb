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
      success("Found webmaster: #{@webmaster.website_name}")
    else
      failure("Webmaster not found: #{@webmaster.website_name}")
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
      success(
        sid: @customer.sid,
        msg: msg
      )
    else
      failure(@customer.errors)
    end

  end

  def create_impression

    if customer.reacted_to? product
      success(
        "Customer already reacted to this product."
      ) and return
    end

    impression = product.impressions.create(
      customer_id: customer.id,
      device_type: message[:device]
    )
    
    if impression
      success("Created impression: #{impression.id}")
    else
      failure(impression.errors)
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

      success(
        data: {
          reactions: @product.reaction_totals,
          customer_reaction: customer.reaction_to(@product)
        },
        msg: msg
      )
    else
      failure(@product.errors)
    end
    
  end

  def get_html
    html = render_to_string('client/_html.haml', :layout => false, :locals => { :x => nil })
    success(html) if html
    failure(html) unless html
  end

  private

  def response msg
    if sesh[:test_mode]
      if msg.is_a?(String) or msg.is_a?(Array)
        {msg:msg}
      else
        msg
      end
    end
  end

  def success msg
    trigger_success(response(msg))
  end

  def failure msg
    trigger_failure(response(msg))
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
      failure 'Too many requests'
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
