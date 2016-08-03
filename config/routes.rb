Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :welcome, as: :welcome, controller: :welcome, only: [:index]
      resources :stock_items, only: [:index]
      resources :configurations, only: [:index, :show]
      resources :orders, only: [:index, :show, :create]
    end
  end

  match '*unmatched_route', :to => 'errors#routing', :via => :all
end
