require 'sidekiq/web'

Alpha::Application.routes.draw do

  devise_for :users, :controllers => { :confirmations => 'users/confirmations',
                                       :omniauth_callbacks => 'users/omniauth_callbacks',
                                       :passwords => 'users/passwords',
                                       :registrations => 'users/registrations',
                                       :sessions => 'users/sessions',
                                       :unlocks => 'users/unlocks' }

  devise_for :administrators

  # Administrator constraint
  administrator = lambda do |request|
    request.env['warden'].authenticate!({ :scope => :administrator })
  end

  namespace :users do
    resources :dashboard, :as => 'dashboard'
    resources :authentications
  end

  namespace :admin do
    resources :dashboard, :as => 'dashboard'
    resources :administrators
    resources :users
  end

  match '/coming-soon' => 'welcome#coming_soon', :as => :coming_soon, :via => :get
  match '/about' => 'welcome#about', :as => :about, :via => :get
  match '/privacy-policy' => 'welcome#privacy_policy', :as => :privacy_policy, :via => :get
  match '/terms-of-service' => 'welcome#terms_of_service', :as => :terms_of_service, :via => :get

  match '/user' => 'welcome#index', :as => :user_root, :via => :get
  match 'admin/dashboard' => 'admin/dashboard#index', :as => :administrator_root, :via => :get

  # Sidekiq admin interface
  constraints administrator do
    mount Sidekiq::Web, at: 'admin/sidekiq'
  end

  namespace 'api', default: { format: 'json' } do

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      # Echo / Debugging / Status
      match 'echo/index' => 'echo#index', via: :get
      match 'echo/show' => 'echo#show', via: [ :get, :post ]
      match 'echo/create' => 'echo#create', via: :post
      match 'echo/update' => 'echo#update', via: :put
      match 'echo/destroy' => 'echo#destroy', via: :delete
      match 'echo/authenticate' => 'echo#authenticate', via: :get
      match 'echo/:status_code' => 'echo#status', via: :get

      # Account Details
      # resources :registrations, :only => [ :create ]
      # resources :sessions, :only => [ :create, :destroy ]
      devise_for :users, :only => [ :registrations, :sessions ]
      resource :account, :only => [ :show ]

    end

  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with 'root'
  # just remember to delete public/index.html.
  if configatron.in_beta
    root :to => 'welcome#soon'
  else
    root :to => 'welcome#index'
  end

  # See how all your routes lay out with 'rake routes'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

