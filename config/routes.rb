Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :welcome, as: :welcome, controller: :welcome, only: [:index, :options]
      resources :stock_items, only: [:index, :show]
    end
  end

  match '*unmatched_route', :to => 'errors#routing', :via => :all
end
