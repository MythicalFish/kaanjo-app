WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  
  # Uncomment and edit the next line to handle the client connected event:
  #subscribe :client_connected, :to => CustomersController, :with_method => :client_connected
  
  namespace :customer do
    subscribe :find, :to => CustomersController, :with_method => :find
    subscribe :create, :to => CustomersController, :with_method => :create
  end
  
end
