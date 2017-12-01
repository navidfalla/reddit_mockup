Rails.application.routes.draw do
  root "links#index"
  resources :links do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
