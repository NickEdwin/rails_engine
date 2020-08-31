Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :create, :update, :destroy]
      resources :merchants, only: [:index, :create, :update, :destroy]
    end
  end
end
