Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      resources :stock_items, only: [:index, :show]
      
      resources :order_requests, only: [:index, :show, :create]

      resources :suggested_rental_set, only: [:show]

      resources :items, only: [:show] do
        get 'rental', on: :collection
      end
      
      resources :configurations, only: [:index, :show] do
        get 'search', on: :collection
      end

      resources :events, only: [:index, :show] do
        get 'search', on: :collection
      end

      resources :boms, only: [:show] do
        get 'stock', on: :member
      end

      resources :category_sets, only: [:show] do
        get 'stock', on: :member
      end

      resources :categories, only: [:show] do
        get 'stock', on: :member
      end

    end
    
  end
  match '*unmatched_route', :to => 'errors#routing', :via => :all
end
