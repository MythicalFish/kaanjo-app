Rails.application.routes.draw do
  devise_for :users
  post '/create-reaction', to: 'reactions#create'
  mount RailsAdmin::Engine => '/', as: 'rails_admin'
end
