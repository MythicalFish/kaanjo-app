class ReactionsApi < WebsocketRails::BaseController

  before_action :set_vars # <-- first!
  before_action :throttle

  def initialize_session
    set(:test_mode, test_mode?)
  end

  def initialize_client
    Thread.new { EventMachine.run } unless EventMachine.reactor_running? && EventMachine.reactor_thread.alive?
    find_webmaster
    failure('webmaster not found') unless set[:webmaster]
    find_campaign
    failure('campaign not found') unless set[:campaign]
    find_customer
    if set[:customer]
      find_product
      impress
      success @response
    else
      failure('customer not found')
    end
    # i'm aware the above is coded strangely but i just couldn't seem to kill a NilClass error...
  end

  def react

    unless message && message.is_a?(Hash)
      failure('"react" action did not receive message (params)')
    end

    if @reaction

      @reaction.scenario_id = message[:id]
      
      if @reaction.save
        set :reaction, @reaction
        success("Reaction updated")
      else
        failure(@reaction.errors)
      end

    else

      @reaction = Reaction.create(
        scenario_id: message[:id],
        impression:  @impression,
        product:     @product,
        customer:    @customer
      )

      set :reaction, @reaction

      if @reaction
        success("Reaction created")
      else
        failure(@reaction.errors)
      end

    end
  end

  def get_buttons
    locals = { campaign: @campaign, product: @product, reaction: @reaction }
    html = render_to_string('client/_buttons.haml', :layout => false, :locals => locals)
    trigger_success(html) if html
    failure unless html
  end

  def get_status
    locals = { campaign: @campaign, product: @product, reaction: @reaction }
    html = render_to_string('client/_status.haml', :layout => false, :locals => locals)
    trigger_success(html) if html
    failure unless html
  end

  def impress
    
    set :device, @message[:device]
    @reaction = @customer.reaction_to(@product)

    if @reaction
      set :reaction, @reaction
      msg "Impression not created (customer already reacted)"
      return
    end

    @impression = @product.impressions.create(
      customer: @customer,
      product: @product,
      device_type: @message[:device]
    )
    
    set :impression, @impression

    if @impression
      msg "Impression created"
    else
      failure(@impression.errors)
    end

  end

  # Webmasters

  def find_webmaster

    @webmaster = Webmaster.find_by_sid(@message[:webmaster_sid])

    if webmaster_valid?
      set :webmaster, @webmaster
    else
      failure("Webmaster not found: #{@webmaster.website_name}")
    end

  end

  # Campaigns

  def find_campaign

    @campaign = @webmaster.campaigns.running.find_by_relative_id(@message[:campaign_id])

    if @campaign
      set :campaign, @campaign
    else
      failure("No active campaign found for webmaster")
    end

  end  

  # Customers

  def find_customer

    if @campaign

      @customer = Customer.find_by_sid(@message[:customer_sid])

      if !@customer
        @customer = @campaign.customers.create
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

    else
      failure('"@campaign" not set, but is required for "find_customer" action')
    end

  end

  # Products

  def find_product

    if @message[:product_sid].blank?
      @product = @campaign.products.find_by_name(@message[:product_name])
    else
      @product = @campaign.products.find_by_sid(@message[:product_sid])
    end

    if !@product && @webmaster.creation_enabled?
      if @campaign.products.length > 300
        failure "Product count exceeds 300, no more can be created"
      end
      @product = @campaign.products.create({
        name: @message[:product_name],
        sid:  @message[:product_sid],
        url:  @message[:url]
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
    puts ''
    puts 'API failure:'
    puts msg
    puts ''
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
    set(:message,message) unless set[:message]
    @message =    set[:message]
    @campaign =   set[:campaign]
    @customer =   set[:customer]
    @webmaster =  set[:webmaster]
    @product =    set[:product]
    @device =     set[:device]
    @impression = set[:impression]
    @reaction =   set[:reaction]
  end

  def webmaster_valid?
    if @webmaster.nil?
      failure("Webmaster not found") # Webmaster not found
    elsif request.env['HTTP_ORIGIN'] != @webmaster.website_url
      failure("URL mismatch") # URLs must match
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
