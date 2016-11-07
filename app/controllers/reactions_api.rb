class ReactionsApi < WebsocketRails::BaseController

  before_action :set_vars # <-- first!
  before_action :throttle

  def initialize_session
    set(:test_mode, test_mode?)
  end

  def initialize_client
    find_webmaster
    find_campaign
    find_customer
    find_product
    impress
    success @response
  end

  def react

    if @reaction

      @reaction.scenario_id = message[:id]
      if @reaction.save
        set_reaction @reaction
        success("Reaction updated")
      else
        failure(@reaction.errors)
      end
    else

      @reaction = @campaign.reactions.create(
        scenario_id: message[:id],
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

  def get_buttons
    html = render_to_string('client/_buttons.haml', :layout => false, :locals => { :scenario => @scenario, :product => @product, :campaign => @campaign })
    trigger_success(html) if html
    failure unless html
  end

  def get_status
    html = render_to_string('client/_status.haml', :layout => false, :locals => { :scenario => @scenario, :product => @product, :campaign => @campaign })
    trigger_success(html) if html
    failure unless html
  end

  def impress
    
    set :device, message[:device]
    set_reaction @customer.reaction_to(@product)

    if @reaction
      msg "Impression not created (customer already reacted)"
      return
    end

    impression = @product.impressions.create(
      customer: @customer,
      campaign: @campaign,
      device_type: message[:device]
    )
    
    if impression
      msg "Impression created"
    else
      failure(impression.errors)
    end

  end

  # Webmasters

  def find_webmaster

    @webmaster = Webmaster.find_by_sid(message[:w_sid])

    if webmaster_valid?
      set :webmaster, @webmaster
    else
      failure("Webmaster not found: #{@webmaster.website_name}")
    end

  end

  # Campaigns

  def find_campaign

    @campaign = @webmaster.campaigns.find_by_relative_id(message[:w_cid])

    if @campaign
      set :campaign, @campaign
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

  private


  def response msg
    if test_mode?
      if msg.is_a?(String)
        {msg:msg}
      else
        msg
      end
    end
  end

  def success msg
    trigger_success(msg)
  end

  def failure msg = nil
    trigger_failure(msg)
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
      connection_store[k] = v
    else
      connection_store
    end
  end

  def set_vars
    @campaign =      set[:campaign]
    @customer =      set[:customer]
    @webmaster =     set[:webmaster]
    @product =       set[:product]
    @device =        set[:device]
    @reaction =      set[:reaction]
    @scenario = set[:scenario]
  end

  def set_reaction reaction
    @reaction = reaction
    set :reaction, @reaction
    @scenario = @reaction ? @reaction.type : nil
    set :scenario, @scenario
  end

  def webmaster_valid?
    if @webmaster.nil?
      failure # Webmaster not found
    elsif request.env['HTTP_ORIGIN'] != @webmaster.website_url
      failure # URLs must match
    else
      msg "Webmaster validated: #{@webmaster.website_url}"
      return true
    end
  end

  def test_mode?
    if \
      set[:test_mode] == true ||\
      ENV['RACK_ENV'] == 'development' ||\
      request.env['HTTP_ORIGIN'] == 'http://dashboard.kaanjo.co'
        return true
    else
      return false
    end
  end

end
