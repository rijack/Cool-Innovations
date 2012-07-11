CoolInnovations::Application.routes.draw do

  resources :shipping_methods do
    get :search, :on => :collection
    post :update_shipping_method, :on => :collection
  end

  resources :order_lines do
    post :set_process_status, :on => :collection
    post :update_order_line, :on => :collection
    post :ship_order_lines, :on => :collection
  end

  resources :orders do
    match :shipped, :on => :collection, :action => :index, :display => "shipped"
  end

  resources :parts do
    post :update_part, :on => :collection
  end

  resources :part_processes do
    post :part_processes, :on => :collection
  end

  resources :hardwares do
    get :search, :on => :collection
    post :update_hardware, :on => :collection
  end

  resources :users
  resources :sessions

  resources :clients do
    get :search, :on => :collection
    post :update_client, :on => :collection
  end

  root to: "home#index"
  get 'login' => "sessions#new"
  get 'logout' => "sessions#destroy"

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
