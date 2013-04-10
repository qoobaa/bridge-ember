Bridge::Application.routes.draw do
  root to: "home#show"

  namespace :api do
    resource :session, only: [:create, :destroy]
    resources :tables, only: [:index, :show, :create] do
      patch :join, on: :member
      patch :quit, on: :member
    end
    resources :boards, only: [] do
      resources :bids, only: [:create]
      resources :cards, only: [:create]
    end
  end
end
