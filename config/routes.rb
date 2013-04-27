Racloop::Application.routes.draw do
 
  root :to => "static_pages#main" 
  # Connect Site
  resource :facebook, :except => :create do
    get :callback, :to => :create
  end


  match "/help",    to:"static_pages#help"

  match "/faq",     to:"static_pages#faq"

  match "/terms",   to:"static_pages#terms"

  match "/privacy", to:"static_pages#privacy"

  match "/learn",   to:"static_pages#learn"  
  
  match "/details", to:"static_pages#details" 
  
  match "/main",    to:"static_pages#main"
  
  match "/home",    to:"static_pages#home"
  
  match "/search",  to:"static_pages#search"
  
  match "/history", to:"static_pages#history"
  
  match "/people",  to:"static_pages#people"
  
  match "/requests",to:"static_pages#requests"
  
  match "/destroy", to:"static_pages#destroy"
  
  match "/saveroute",to:"static_pages#saveroute"
  
  match "/savelist",to:"static_pages#savelist"
  
  match "/destroy_favourite",to:"static_pages#destroy_favourite" 
  # match "/users",   to:"user_informations#users"
 
# match "/help" "static_pages/help"
# 
  # match "/faq" "static_pages/faq"
# 
  # match "/terms" "static_pages/terms"
# 
  # match "/privacy" "static_pages/privacy"

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
