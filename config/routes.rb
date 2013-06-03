Bridge::Application.routes.draw do
  root to: "home#show"

  namespace :api do
    resource :session, only: %w[create destroy]
    resources :tables, only: %w[create] do
      patch :join, on: :member
      patch :quit, on: :member
    end
    resources :boards, only: %w[] do
      resources :bids, only: %w[create]
      resources :cards, only: %w[create]
      resources :claims, only: %w[create] do
        patch :accept, on: :member
        patch :reject, on: :member
      end
    end
  end

  namespace :stream do
    resources :tables, only: %w[index show]
  end
end
