Rails.application.routes.draw do
  root "links#index"
  resources :links do
    member do
      put "up", to: "links#upvote"
      put "down", to: "links#downvote"
    end
    resources :comments do
      member do
        put "up", to: "comments#upvote"
        put "down", to: "comments#downvote"
      end
    end
  end
  resources :comments do
    member do
      put "up", to: "comments#upvote"
      put "down", to: "comments#downvote"
    end
    resources :comments do
      member do
        put "up", to: "comments#upvote"
        put "down", to: "comments#downvote"
      end
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
