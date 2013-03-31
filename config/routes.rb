Bridge::Application.routes.draw do
  root to: "home#show"

  namespace :api do
    resource :session, only: [:create, :destroy]
    resource :channel, only: [:create]
  end
end
