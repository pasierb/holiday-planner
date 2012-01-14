HolidayplannerV3::Application.routes.draw do
  


  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  devise_for :user, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  #match "/(:localization)" => "planner#show"
  scope "/(:localization)", :localization => /default|pl|en|ir|it/ do
    match "planner/(:year)" => "planner#show", :as => :planner
    match "leave_request" => "leave_requests#show", :as => :leave_request
  end

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
  resources :users do
    resources :days
  end
  
  match "/posts" => "posts#index"
  match "/posts/:permalink" => "posts#show", :as => :post

  namespace :admin do
    resources :custom_pages
    resources :posts
  end

  get "/:permalink" => "custom_pages#show"

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "planner#show", :localization => 'default'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
