Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/', as: 'rails_admin'
  post '/create-reaction', to: 'reactions#create'
end
