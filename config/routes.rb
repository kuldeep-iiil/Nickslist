NicksListProj::Application.routes.draw do
  post "/admin/AddSiteUser"
  get "/admin/AddSiteUser"
  post "/admin/AdminLogin"
  get "/admin/AdminLogin"
  post "/admin/AdminPanel"
  get "/admin/AdminPanel"
  post "/admin/ListUsers"
  get "/admin/ListUsers"
  post "/authorize_payment/relay_response"
  get "/authorize_payment/relay_response"
  post "/authorize_payment/payment"
  get "/authorize_payment/payment"
  post "/authorize_payment/receipt"
  get "/authorize_payment/receipt"
  post "/authorize_payment/error"
  get "/authorize_payment/error"  
  post "/user_profile/EditProfile"
  get "/user_profile/EditProfile"
  post "/user_profile/ViewProfile"
  get "/user_profile/ViewProfile"
  post "/user_profile/UpdateProfile"
  get "/user_profile/UpdateProfile"
  post "/review_customers/PrevNextReview"
  get "/review_customers/PrevNextReview"
  post "/review_customers/TermsConditions"
  get "/review_customers/TermsConditions"
  post "/review_customers/UpdateReviewData"
  get "/review_customers/UpdateReviewData"
  post "/review_customers/UpdateReviews"
  get "/review_customers/UpdateReviews"
  post "/review_customers/AddReviewData"
  get "/review_customers/AddReviewData"
  post "/review_customers/AddReviews"
  get "/review_customers/AddReviews"
  post "/review_customers/ListReviews"
  get "/review_customers/ListReviews"
  post "/review_customers/ReadReviews"
  get "/review_customers/ReadReviews"
  post "/authentication/ChangePassword"
  get "/authentication/ChangePassword"
  post "/authentication/SavePassword"
  get "/authentication/SavePassword"
  post "/authentication/requestpassword"
  get "/authentication/requestpassword"
  post "/authentication/login"
  get "/authentication/login"
  post "/authentication/logout"
  get "/authentication/logout"
  post "/user_registeration/show"
  get "/user_registeration/show"
  post "/user_registeration/paid"
  get "/user_registeration/paid"
  post "/user_registeration/Finish"
  get "/user_registeration/Finish"
  post "/user_registeration/ipn"
  get "/user_registeration/ipn"
  post "/user_registeration/revoked"
  get "/user_registeration/revoked"
  post "/user_registeration/PaypalPayment"
  get "/user_registeration/PaypalPayment"
  post "/user_registeration/RedirectToPaymentForm"
  get "/user_registeration/RedirectToPaymentForm"
  post "/user_registeration/GetSubscription"
  get "/user_registeration/GetSubscription"
  post "/user_registeration/GetRegister"
  get "/user_registeration/GetRegister"
  post "/user_registeration/GetUserInfo"
  get "/user_registeration/GetUserInfo"
  post "/customer_search/LoadReviews"
  get "/customer_search/LoadReviews"
  post "/customer_search/GetDetails"
  get "/customer_search/GetDetails"
  post "/nicks_list/Index"
  get "/nicks_list/Index"
  post "/nicks_list/About"
  get "/nicks_list/About"
  post "/nicks_list/HowItWorks"
  get "/nicks_list/HowItWorks"
  #root to: "/nicks_list/Index"
  root to: "nicks_list#Index"
  
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
