Rails.application.routes.draw do
  namespace :store do
    resources :categories, only: %w[create update destroy]

    resources :products, except: %w[index show] do
      collection do
        post 'position'
      end
      resources :categorizations, only: %w[create destroy]
    end

    class Category::Constraint
      def self.matches?(request)
        Category.exists?(name: request.params[:category].titleize)
      end
    end
    get 'cart' => 'items#index', as: :cart
    constraints Category::Constraint do
      get ':category' => 'products#index', as: :c
    end
    post ':product/add' => 'items#create', as: :add_to_cart
    get ':product'  => 'products#show',  as: :product_listing
    root to: 'products#index'
  end

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end

