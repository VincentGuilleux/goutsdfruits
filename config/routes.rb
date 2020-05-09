Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {sessions: 'users/sessions'}
  devise_for :clients, path: 'clients', controllers: {sessions: 'clients/sessions'}

  # UNLOGGED PAGES
  root to: 'pages#home'
  get "/pages/:page" => "pages#show"

  # USER ROUTES

  resource :dashboard, only: :show

  resources :clients, only: [:index] #Not nested because not linked to a client show (the client will be input in the form)

  resources :products, only: [:index, :show, :new, :create] do
    resources :product_lots, only: [:create] # has many between orders & product_lots ? Not necessary
  end

  resources :orders, only: [:index, :new, :create] do # No show because collapse (no specific URL)
    member do
      patch :prepare
      patch :deliver
      patch :pay
    end
  end
  # resources :order_lines, only: [:create] #created by Anne for new order form

  # CLIENT ROUTES

  resource :dashboard_client, only: :show
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
