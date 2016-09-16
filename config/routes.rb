Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      resources :stock_items, only: [:index, :show]
      
      resources :order_requests, only: [:index, :show, :create]
      
      resources :configurations, only: [:index, :show] do
        collection do
          get 'search'
        end
      end


      resources :events, only: [:index, :show] do
        collection do
          get 'search'
        end
      end

      scope :rentails do
        resources :events, only: [:show] do
          collection do
            get 'suggested'
          end
        end
      end

      scope :avaliable_stock do
        resources :events, only: [:show] do
          resources :categories, only: [:show]
          resources :configurations, only: [:show]
        end
      end
      
    end
  end
  match '*unmatched_route', :to => 'errors#routing', :via => :all
end
