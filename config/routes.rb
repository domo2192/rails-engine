Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'revenue', to: 'revenue#between_dates'
      namespace :revenue do
        get '/merchants', to: 'revenue#most_revenue'
        get '/unshipped', to: 'revenue#unshipped_revenue'
        get '/merchants/:id', to: 'revenue#merchant_revenue'
        get 'items', to: 'revenue#item_revenue'
      end
    end
  end

  #   get '/most_revenue', to: 'search#most_revenue'
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#find_one'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find_all', to: 'search#find_all'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      get 'merchants/most_items', to: 'merchants#most_items'
      resources :merchants do
        get '/items', to: 'merchant_items#show'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      resources :items do
        get '/merchant', to: 'items_merchant#show'
      end
    end
  end
end
