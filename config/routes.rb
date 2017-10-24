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

  namespace :api do
    namespace :v1 do
      resources :coaches, only: [:index]
      resources :groups, only: [:index, :show]
    end
  end
end
