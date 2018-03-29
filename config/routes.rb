Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'restaurants#index'
  resources :categories, only: :show

  resources :restaurants, only: %i[index show] do
    resources :comments, only: %i[create destroy]

      # 瀏覽所有餐廳的最新動態
      # GET restaurants/feeds
    collection do
      get :feeds
      # 十大人氣餐廳    
      get :ranking
    end

      # 瀏覽個別餐廳的 Dashboard
      # GET restaurants/:id/dashboard
    member do
      get :dashboard

      # 收藏 / 取消收藏
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
