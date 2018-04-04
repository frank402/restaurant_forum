class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  #order(created_at: :desc) - 可以指定根據哪一個欄位來排序，並設定要升序 (asc) 還是降序 (desc)。
  # limit(10) - 最多回傳幾筆資料，在這裡會回傳排序好的前 10 筆
  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  # POST /restaurants/:id/favorite
  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    @restaurant.count_favorites
    redirect_back(fallback_location: root_path) # 導回上一頁
  end

  # POST /restaurants/:id/unfavorite
  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    @favorites = Favorite.where(restaurant: @restaurant, user: current_user)
    @restaurant.count_favorites
    @favorites.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def like
    @restaurant = Restaurant.find(params[:id])
    @restaurant.likes.create!(user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    @restaurant = Restaurant.find(params[:id])
    @likes = Like.where(restaurant: @restaurant, user: current_user)
    @likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  #order(created_at: :desc) - 可以指定根據哪一個欄位來排序，並設定要升序 (asc) 還是降序 (desc)。
  # limit(10) - 最多回傳幾筆資料，在這裡會回傳排序好的前 10 筆
  def ranking
    @restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end
end
