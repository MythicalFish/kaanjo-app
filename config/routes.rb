Rails.application.routes.draw do
  
  post '/create-reaction', to: 'reactions#create'
  root to: 'application#dashboard'

  get '/products/:sid', to: 'products#show', as: 'product'
  resources :products, except: 'show'

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
    delete 'account' => 'devise/registrations#destroy'
    post   'signup' => 'devise/registrations#create', :as => :user_registration 
    patch  'account' => 'devise/registrations#update'
    put    'account' => 'devise/registrations#update'

  end

  get '/:id', to: 'pages#show'
  
  
end
