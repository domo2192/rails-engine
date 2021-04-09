Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'merchants/most_items', to: 'merchants#most_items'
      get 'revenue', to: 'revenue#between_dates'
      namespace :merchants do
        get '/find', to: 'search#find_one'
      end
      namespace :items do
        get '/find_all', to: 'search#find_all'
      end
      namespace :revenue do
        get '/merchants', to: 'revenue#most_revenue'
        get '/unshipped', to: 'revenue#unshipped_revenue'
        get '/merchants/:id', to: 'revenue#merchant_revenue'
        get 'items', to: 'revenue#item_revenue'
      end
      resources :items do
        get '/merchant', to: 'items_merchant#show'
      end
      resources :merchants do
        get '/items', to: 'merchant_items#show'
      end
    end
  end
end 
