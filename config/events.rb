WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  
  namespace :webmaster do
    subscribe :find, :to => ReactionsApi, :with_method => :find_webmaster
  end

  namespace :customer do
    subscribe :find, :to => ReactionsApi, :with_method => :find_customer
    subscribe :create, :to => ReactionsApi, :with_method => :create_customer
  end

  namespace :product do
    subscribe :find, :to => ReactionsApi, :with_method => :find_product
  end
  
end
