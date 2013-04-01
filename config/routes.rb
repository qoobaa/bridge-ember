Bridge::Application.routes.draw do
  root to: "home#show"

  namespace :api do
    resource :session, only: [:create, :destroy]
    resource :channel, only: [:create]
    resources :boards, only: [:show] do
      resources :bids, only: [:create]
      resources :cards, only: [:create]
    end
  end
end
