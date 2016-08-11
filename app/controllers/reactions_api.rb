class ReactionsApi < WebsocketRails::BaseController

  before_action :set_vars # <-- first!
  before_action :throttle

  def initialize_session
    set(:test_mode, ENV['RACK_ENV'] == 'development' ? true : false)
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

    @webmaster = Webmaster.find_by_sid(message[:w_sid])

    if @webmaster
      set :webmaster, @webmaster
      msg "Webmaster found: #{@webmaster.sid}"
    else
      failure("Webmaster not found: #{@webmaster.website_name}")
    end

  end

  # Customers

  def find_customer

    @customer = Customer.find_by_sid(message[:c_sid])

    if !@customer
      @customer = Customer.create(
        webmaster: @webmaster
      )
      @response[:c_sid] = @customer.sid
      msg "Customer created: #{@customer.sid}"
    else
      msg "Customer found: #{@customer.sid}"
    end

    if @customer
      set :customer, @customer
    else
      failure(@customer.errors)
    end

  end

  def impress
    
    set :device, message[:device]
    set_reaction @customer.reaction_to(@product)

    if @reaction
      msg "Impression not created (customer already reacted)"
      return
    end

    impression = @product.impressions.create(
      customer_id: @customer.id,
      device_type: message[:device]
    )
    
    if impression
      msg "Impression created"
    else
      failure(impression.errors)
    end

  end

  def react

    if @reaction
      @reaction.reaction_type_id = message[:id]
      if @reaction.save
        set_reaction @reaction
        success("Reaction updated")
      else
        failure(@reaction.errors)
      end
    else

      @reaction = Reaction.create(
        reaction_type_id: message[:id],
        customer_id: @customer.id,
        product_id: @product.id,
        device_type: @device
      )

      set_reaction @reaction

      if @reaction
        success("Reaction created")
      else
        failure(@reaction.errors)
      end

    end
  end

  # Products

  def find_product
    
    @product = @webmaster.products.find_by_name(message[:p_sid])

    if !@product && @webmaster.creation_enabled?
      @product = @webmaster.products.create({
        name: message[:p_sid],
        url: message[:url]
      })
      msg "Product created: #{@product.name}"
    else
      msg "Product found: #{@product.name}"
    end

    if @product
      set :product, @product
    else
      failure(@product.errors)
    end
    
  end

  def html
    html = render_to_string('client/_html.haml', :layout => false, :locals => { :reaction_type => @reaction_type, :product => @product })
    trigger_success(html) if html
    failure unless html
  end

  private

  def response msg
    if set[:test_mode]
      if msg.is_a?(String)
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
    @response = {} unless @response
    @response[:msg] = '' unless @response[:msg]
    @response[:msg] << "#{msg}\n"
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
      failure # Too many requests
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
    @customer =      set[:customer]
    @webmaster =     set[:webmaster]
    @product =       set[:product]
    @device =        set[:device]
    @reaction =      set[:reaction]
    @reaction_type = set[:reaction_type]
  end

  def set_reaction reaction
    @reaction = reaction
    set :reaction, @reaction
    @reaction_type = @reaction ? @reaction.type : nil
    set :reaction_type, @reaction_type
  end

end
