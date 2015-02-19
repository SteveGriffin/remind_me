Rails.application.routes.draw do
  resources :users

  resources :reminders

  root 'home#index'
  get 'reminder' => 'reminders#new'

  #get 'authentication/login', :as => :login
  get "/auth/:provider/callback/" => "authentication#create"
  get "/auth/:provider/" => "authentication#create", :as => :login
  get "/signout" => "authentication#destroy", :as => :signout

  get 'dashboard/:id' => 'dashboard#show', :as => :dashboard

  post 'twilio/voice/:id' => 'twilio#voice'

  patch 'dashboard/:id/update_user_phone' => 'dashboard#update_user_phone'

  get 'admin' => 'admin#login'
  post 'admin' => 'admin#authenticate'
  get '/admin/panel' => 'admin#index'

  post 'mass_message' => 'reminders#mass_message'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
