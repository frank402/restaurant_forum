Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'restaurants#index'
  resources :categories, only: :show

  resources :restaurants, only: %i[index show] do
    resources :comments, only: %i[create destroy]

    collection do
      get :feeds
    end

    member do
      get :dashboard
      post :favorite
      post :unfavorite

      post :like
      post :unlike
    end
  end

  resources :users, only: %i[show edit update]

  namespace :admin do
    resources :restaurants
    resources :categories
    root 'restaurants#index'
  end
end
