Rails.application.routes.draw do
  
  devise_for :users
  
  post '/create-reaction', to: 'reactions#create'
  root to: 'dashboard#show'

  resources :webmasters

end
