Rails.application.routes.draw do
  resources :items, only: [:index]
  resources :users, only: [:show] do
    #nested resource for the items
      resources :items
  end
end
