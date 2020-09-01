Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants_search#show'

      get '/items/find', to: 'items_search#show'

      resources :items do
        get '/merchant', to: 'items#merchant_show'

      end
      resources :merchants do
        get '/items', to: 'merchants#items_index'
      end
    end
  end
end
