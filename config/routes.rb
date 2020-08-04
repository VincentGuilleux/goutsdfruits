Rails.application.routes.draw do
  devise_for :clients

  # UNLOGGED PAGES
  root to: 'pages#home'
  get "/pages/:page" => "pages#show"
  post "send_contact" => "pages#send_contact"

  # USER ROUTES
  resource :dashboard, only: :show

  resources :clients do #Not nested because not linked to a client show (the client will be input in the form)
  end

  resources :products do
    resources :product_lots, only: [:create] # has many between orders & product_lots ? Not necessary
  end

  resources :orders, only: [:index, :new, :create, :destroy] do # No show because info collapsed from /dashboard or /orders (no dedicated page for one order)
    member do
      patch :prepare
      patch :deliver
      patch :pay
    end
  end

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
