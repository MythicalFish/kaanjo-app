Rails.application.routes.draw do
  
  root to: 'dashboard#show'

  resources :products
  resources :campaigns
  get '/campaigns/:id/implementation', to: 'campaigns#implementation', as: 'implement_campaign'
  resources :campaign_templates 
  resources :webmasters
  resources :admins, except: [:show]

  devise_for :users, :skip => [:sessions, :registrations]

  as :user do

    get    'login' => 'devise/sessions#new', :as => :new_user_session
    get    'signup' => 'devise/registrations#new', :as => :new_user_registration 
    get    'account' => 'devise/registrations#edit', :as => :edit_user_registration 
    
    get    'signup/cancel' => 'devise/registrations#cancel', :as => :cancel_user_registration 
    post   'login' => 'devise/sessions#create', :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    delete 'signup' => 'devise/registrations#destroy'
    post   'signup' => 'devise/registrations#create', :as => :user_registration 
    patch  'signup' => 'devise/registrations#update'
    put    'signup' => 'devise/registrations#update'

  end

  #get '/setup', to: 'pages#show'
  
  
end
