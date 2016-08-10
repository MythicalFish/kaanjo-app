WebsocketRails::EventMap.describe do

  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  
  subscribe :init, :to => ReactionsApi, :with_method => :initialize_client
  subscribe :html, :to => ReactionsApi, :with_method => :html
  subscribe :react, :to => ReactionsApi, :with_method => :react
  
end
