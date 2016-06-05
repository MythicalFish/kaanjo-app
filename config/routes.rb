Rails.application.routes.draw do
  post '/create-reaction', to: 'reactions#create'
  mount RailsAdmin::Engine => '/', as: 'rails_admin'
end
