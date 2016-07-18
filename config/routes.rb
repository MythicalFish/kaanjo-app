Rails.application.routes.draw do
  
  post '/create-reaction', to: 'reactions#create'
  root to: 'dashboard#show'

  resources :products
  resources :webmasters, skip: [:index]
  
  devise_for :users, :skip => [:sessions, :registrations]
  
  as :user do

    get    'login' => 'devise/sessions#new', :as => :new_user_session
    get    'register' => 'devise/registrations#new', :as => :new_user_registration 
    get    'account' => 'devise/registrations#edit', :as => :edit_user_registration 
    
    get    'users/cancel' => 'devise/registrations#cancel', :as => :cancel_user_registration 
    post   'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    delete 'users' => 'devise/registrations#destroy'
    post   'users' => 'devise/registrations#create', :as => :user_registration 
    patch  'users' => 'devise/registrations#update'
    put    'users' => 'devise/registrations#update'

  end
  
end
