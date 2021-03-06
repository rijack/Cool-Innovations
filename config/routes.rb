CoolInnovations::Application.routes.draw do

  resources :stations do
    post :update_station, :on => :collection
    get :index_floor, :on => :collection
  end

  resources :attachments

  resources :part_process_categories do
    post :update_part_process_category, :on => :collection
    post :set_sort_priority, :on => :collection
  end

  resources :hardware_categories do
    post :update_hardware_category, :on => :collection
    post :set_sort_priority, :on => :collection
  end

  resources :sample_lines

  resources :comments

  resources :shipping_methods do
    get :search, :on => :collection
    post :update_shipping_method, :on => :collection
  end

  resources :order_lines do
    post :set_process_status, :on => :collection
    post :update_order_line, :on => :collection
    post :update_order_lines, :on => :collection
    post :reset_order_line_status, :on => :collection
    post :assign_user, :on => :collection
    post :update_order_line_process_status, :on => :collection
    get :accordion_details, :on => :member
  end

  resources :orders do
    match :shipped, :on => :collection, :action => :index, :display => "shipped"
    match :update_search_dropdowns, :on => :collection
  end

  resources :parts do
    get  :search, :on => :collection
    post :update_part, :on => :collection
    post :set_required_process_priority, :on => :member
    get :accordion_details, :on => :member
  end

  resources :part_processes do
    post :part_processes, :on => :collection
    post :set_order_line_priority, :on => :member
    post :reset_order_line_priority, :on => :member
    post :update_part_process, :on => :collection
    get :accordion_details, :on => :member
  end

  resources :hardwares do
    get :search, :on => :collection
    post :update_hardware, :on => :collection
    get :accordion_details, :on => :member
  end

  resources :users do
    post :update_user, :on => :collection
    post :set_process_priority, :on => :member
  end
  resources :sessions

  resources :clients do
    get :search, :on => :collection
    post :update_client, :on => :collection
    get :accordion_details, :on => :member
  end


  root to: "sessions#index"
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
