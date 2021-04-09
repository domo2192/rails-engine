Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'merchants/most_items', to: 'merchants#most_items'
      get '/revenue', to: 'revenue#between_dates'
      get '/revenue/merchants', to: 'revenue#most_revenue'
      get '/revenue/unshipped', to: 'revenue#unshipped_revenue'
      get '/revenue/merchants/:id', to: 'revenue#merchant_revenue'
      get '/revenue/items', to: 'revenue#item_revenue'
      namespace :merchants do
        get '/find', to: 'search#find_one'
      end
      namespace :items do
        get '/find_all', to: 'search#find_all'
      end
      resources :items do
        get '/merchant', to: 'items_merchant#show'
      end
      resources :merchants, only: [:index, :show] do
        get '/items', to: 'merchant_items#show'
      end
    end
  end
end
