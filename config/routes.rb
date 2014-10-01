Rails.application.routes.draw do

  resources :companies


  namespace :api do
    scope '/:current_company/:current_branch' do
      # Recursos genericos
      scope '/resource', :defaults => { :format => 'json' } do
        match ':resource/metadata' => 'resources#metadata', :via => :get
        match ':resource/query' => 'resources#query', :via => :get
        match ':resource' => 'resources#index', :via => :get
        match ':resource/new' => 'resources#new', :via => :get
        match ':resource' => 'resources#create', :via => [:post, :options]
        match ':resource/:id' => 'resources#show', :via => :get
        match ':resource/:id/edit' => 'resources#edit', :via => :get
        match ':resource/:id' => 'resources#update', :via => [:put, :options]
        match ':resource/:id' => 'resources#destroy', :via => :delete
      end
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
