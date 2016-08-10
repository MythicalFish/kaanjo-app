class ReactionsApi < WebsocketRails::BaseController

  before_action :throttle
  before_action :set_vars

  def initialize_session
    set :webmaster_id, nil
    set :product_id, nil
    set :customer_id, nil
    set :test_mode, true
  end

  def initialize_client

    find_webmaster
    find_customer
    find_product
    impress
    success @response

  end

  # Webmasters

  def find_webmaster

    @webmaster = Webmaster.find_by_sid(message[:wid])

    if @webmaster
      set :webmaster_id, @webmaster.id
      msg "Webmaster found: #{@webmaster.sid}"
    else
      failure("Webmaster not found: #{@webmaster.website_name}")
    end

  end

  # Customers

  def find_customer
    @customer = Customer.find_by_sid(message[:cid])

    if !@customer
      @customer = Customer.create(
        webmaster: @webmaster
      )
      @response[:cid] = @customer.sid
      msg "Customer created: #{@customer.sid}"
    else
      msg "Customer found: #{@customer.sid}"
    end

    if @customer
      set :customer_id, @customer.id
    else
      failure(@customer.errors)
    end

  end

  def impress

    if @customer.reacted_to? @product
      msg "Impression not created (customer already reacted)"
      return
    end

    impression = @product.impressions.create(
      customer_id: @customer.id,
      device_type: message[:device]
    )
    
    if impression
      set :device, message[:device]
      msg "Impression created"
    else
      failure(impression.errors)
    end

  end

  def react

    reaction = @customer.reaction_to(@product)

    if reaction
      reaction.reaction_type_id = message[:id]
      if reaction.save
        success("Reaction updated")
      else
        failure(reaction.errors)
      end
    else

      reaction = Reaction.create(
        reaction_type_id: message[:id],
        customer_id: @customer.id,
        product_id: @product.id,
        device_type: @device
      )

      if reaction
        success("Reaction created")
      else
        failure(reaction.errors)
      end

    end
  end

  # Products

  def find_product
    
    @product = @webmaster.products.find_by_name(message[:pid])

    if !@product && @webmaster.creation_enabled?
      @product = @webmaster.products.create({
        name: message[:product],
        url: message[:url]
      })
      msg "Product created: #{@product.name}"
    else
      msg "Product found: #{@product.name}"
    end
    if @product
      set :product_id, @product.id
    else
      failure(@product.errors)
    end
    
  end

  def html
    html = render_to_string('client/_html.haml', :layout => false, :locals => { :x => nil })
    success(html) if html
    failure(html) unless html
  end

  private

  def response msg
    if set[:test_mode]
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

  def msg msg
    @response = "" unless @response
    @response << "#{msg}\n"
  end

  def throttle

    return unless @customer

    time = Time.now 
    index_limit = 5

    if @customer.throttle_timer_1.nil? || time > @customer.throttle_timer_1
      throttle_reset
    elsif time < @customer.throttle_timer_1 && index_limit > @customer.throttle_index_1
      throttle_increment
    else
      failure 'Too many requests'
    end

  end

  def throttle_reset
    @customer.update_attributes!(
      throttle_timer_1: Time.now + 5,
      throttle_index_1: 1
    )
  end

  def throttle_increment
    @customer.throttle_index_1 += 1
    @customer.save
  end

  def set k = nil, v = nil
    if k && v
      controller_store[k] = v
    else
      controller_store
    end
  end

  def set_vars
    @customer = Customer.find_by_id(set[:customer_id])
    @webmaster = Webmaster.find_by_id(set[:webmaster_id])
    @product = Product.find_by_id(set[:product_id])
    @device = set[:device]
  end

end
