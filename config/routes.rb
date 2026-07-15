Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :sign_up, only: [ :show, :create ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # get "/products", to: "products#index"

  # get "/products/new", to: "products#new" # a form
  # post "/products", to: "products#create"

  # get "/products/:id", to: "products#show"
  # get "/products/:id/edit", to: "products#edit" # a form
  # put "/products/:id", to: "products#update"
  # patch "/products/:id", to: "products#update"

  # delete "/products/:id", to: "products#destroy"
  resources :products, only: [ :index, :show ] do
    resources :subscribers, only: [ :create ]
    resource :wishlist, only: [ :create ], module: :products
  end
  resource :unsubscribe, only: [ :show ]
  resources :wishlists do
    resources :wishlist_products, only: [ :update, :destroy ], module: :wishlists
  end
  root "products#index"

  namespace :settings do
    resource :email, only: [ :show, :update ]
    resource :password, only: [ :show, :update ]
    resource :profile, only: [ :show, :edit, :update ]
    resource :user, only: [ :destroy ]

    root to: redirect("/settings/profile")
  end

  namespace :email do
    resources :confirmations, param: :token, only: [ :show ]
  end

  namespace :store do
    resources :products
    resources :users

    root to: redirect("/store/products")
  end
end
