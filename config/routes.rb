Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items do
        get '/merchant', to: 'items#merchant_show'

      end
      resources :merchants do
        get '/items', to: 'merchants#items_index'
      end
    end
  end
end
