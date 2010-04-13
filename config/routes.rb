ActionController::Routing::Routes.draw do |map|
  map.resources :races
  map.resources :unit_attributes
  map.resources :users
  map.resources :sessions, :only => [:new, :create, :destroy]
  
  map.signin  '/signin',  :controller => 'sessions', :action => 'new'
  map.signout '/signout', :controller => 'sessions', :action => 'destroy'
  
  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.about   '/about',   :controller => 'pages', :action => 'about'
  map.help    '/help',    :controller => 'pages', :action => 'help'

  map.signup  '/signup',   :controller => 'users', :action => 'new'
  map.add_friend  'users/:id/add_friend',   :controller => 'users', :action => 'add_friend'
  map.remove_friend  'users/:id/remove_friend',   :controller => 'users', :action => 'remove_friend'
  map.accept_friend  'users/:id/accept_friend',   :controller => 'users', :action => 'accept_friend'
  map.reject_friend  'users/:id/reject_friend',   :controller => 'users', :action => 'reject_friend'
  map.cancel_friendship_request  'users/:id/cancel_friendship_request',   :controller => 'users', :action => 'cancel_friendship_request'
  
  map.game_editor    '/game_editor',    :controller => 'pages', :action => 'game_editor'

  map.edit  'unit_attributes/:id/edit',   :controller => 'unit_attributes', :action => 'edit'
  map.edit  'races/:id/edit',   :controller => 'races', :action => 'edit'
  
  map.add_race_bonus  'races/:id/add_bonus',   :controller => 'races', :action => 'add_bonus'
  map.delete_race_bonus  'races/:id/delete_bonus',   :controller => 'races', :action => 'delete_bonus'
  map.edit_race_bonus  'races/:id/edit_bonus',   :controller => 'races', :action => 'edit_bonus'
  map.update_race_bonus  'races/:id/update_bonus',   :controller => 'races', :action => 'update_bonus'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :controller => 'pages', :action => 'home'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
