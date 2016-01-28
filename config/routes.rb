Rails.application.routes.draw do
  resources :products, except: %w[index show] do
    collection do
      post 'position'
    end
  end

  get ':product'  => 'products#show'
  get ':category' => 'products#index'
  root to: 'products#index'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end

