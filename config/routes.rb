Bridge::Application.routes.draw do
  root to: "home#show"

  namespace :api do
    resource :channel, only: [:create]
  end
end
