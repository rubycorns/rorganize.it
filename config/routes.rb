RailsGirlsApp::Application.routes.draw do

  devise_for :people, controllers: { registrations: 'registrations', omniauth_callbacks: "omniauth_callbacks" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#index'

  get 'about' => 'pages#about'
  get 'welcome' => 'pages#welcome'
  get 'conduct' => 'pages#conduct'

  #resources routing declare all of the common routes for the certain controller (index, new, edit etc...)
  resources :groups do
    resources :topics do
      resources :comments, only: [:create]
    end

    member do
      get :manage_members
    end
  end
  resources :people
  resources :coaches
  resources :memberships, only: [:create, :destroy, :update]
  resources :posts
  resource :dashboard, only: [:show] do
    resources :admins, only: [:create, :destroy]
  end

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
