Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#find_one'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find_all', to: 'search#find_all'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      resources :merchants do
        get '/items', to: 'merchant_items#show'
      end
      resources :items do
        get '/merchant', to: 'items_merchant#show'
      end
    end
  end
end
