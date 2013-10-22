NicksListProj::Application.routes.draw do
  post "user_registeration/show"
  get "user_registeration/show"
  post "user_registeration/PaypalPayment"
  get "user_registeration/PaypalPayment"
  post "user_registeration/GetSubscription"
  get "user_registeration/GetSubscription"
  post "user_registeration/GetRegister"
  get "user_registeration/GetRegister"
  post "user_registeration/GetUserInfo"
  get "user_registeration/GetUserInfo"
  post "customer_search/GetDetails"
  get "customer_search/GetDetails"
  post "nicks_list/Index"
  get "nicks_list/Index"
  post "nicks_list/About"
  get "nicks_list/About"
  post "nicks_list/HowItWorks"
  get "nicks_list/HowItWorks"
  root to: "nicks_list#Index"
  
  resources :registration do
    collection do
      get :PaypalPayment
      post :PaypalPayment
      get :GetSubscription
      post :GetSubscription
      get :GetRegister
      post :GetRegister
      get :show
      post :show
    end
  end
  
  resources :orders do
    collection do
      get :paid
      get :revoked
      post :ipn
    end
  end
  
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
