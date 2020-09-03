Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants_search#show'
      get '/merchants/find_all', to: 'merchants_search#index'

      get "/merchants/most_revenue", to: 'business_revenues#index'
      get "/merchants/most_items", to: 'business_revenues#show'

      get '/items/find', to: 'items_search#show'
      get '/items/find_all', to: 'items_search#index'

      get '/revenue', to: 'business_revenues#revenue'

      resources :items do
        get '/merchant', to: 'items#merchant_show'

      end
      resources :merchants do
        get '/items', to: 'merchants#items_index'
      end
    end
  end
end
